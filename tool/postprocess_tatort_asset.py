#!/usr/bin/env python3
"""Apply Spurfunk noir grading to generated Tatort assets."""

from __future__ import annotations

import sys
from pathlib import Path

from PIL import Image, ImageEnhance, ImageOps, ImageFilter, ImageDraw


def grade_portrait(img: Image.Image) -> Image.Image:
    img = img.convert('RGB')
    gray = ImageOps.grayscale(img).convert('RGB')
    warm = Image.merge(
        'RGB',
        (
            gray.split()[0],
            ImageEnhance.Brightness(gray.split()[1]).enhance(0.95),
            ImageEnhance.Brightness(gray.split()[2]).enhance(0.82),
        ),
    )
    # Keep more source color for skin tones and accent lights.
    img = Image.blend(warm, img, 0.58)
    img = ImageEnhance.Contrast(img).enhance(1.14)
    img = ImageEnhance.Color(img).enhance(1.08)
    img = ImageEnhance.Brightness(img).enhance(0.94)
    # Subtle red push in midtones (brand accent).
    r, g, b = img.split()
    r = ImageEnhance.Brightness(r).enhance(1.04)
    b = ImageEnhance.Brightness(b).enhance(0.96)
    img = Image.merge('RGB', (r, g, b))
    grain = Image.effect_noise(img.size, 12).convert('L')
    grain = ImageEnhance.Brightness(grain).enhance(0.22)
    grain_rgb = Image.merge('RGB', (grain, grain, grain))
    return Image.blend(img, grain_rgb, 0.04)


def grade_scene(img: Image.Image) -> Image.Image:
    img = img.convert('RGB')
    img = ImageEnhance.Color(img).enhance(0.55)
    img = ImageEnhance.Contrast(img).enhance(1.1)
    img = ImageEnhance.Brightness(img).enhance(0.82)
    w, h = img.size
    vig = Image.new('L', (w, h), 0)
    draw = ImageDraw.Draw(vig)
    draw.ellipse((-w * 0.12, -h * 0.08, w * 1.12, h * 1.08), fill=215)
    vig = vig.filter(ImageFilter.GaussianBlur(radius=max(w, h) // 14))
    vig_rgb = Image.merge('RGB', (vig, vig, vig))
    return Image.composite(
        ImageEnhance.Brightness(img).enhance(0.78),
        img,
        vig.point(lambda p: min(255, int(p * 0.5))),
    )


def main() -> None:
    if len(sys.argv) < 3:
        print('Usage: postprocess_tatort_asset.py <portrait|scene> <input> [output]')
        sys.exit(1)

    kind, input_path = sys.argv[1], Path(sys.argv[2])
    output_path = Path(sys.argv[3]) if len(sys.argv) > 3 else input_path

    img = Image.open(input_path)
    result = grade_portrait(img) if kind == 'portrait' else grade_scene(img)
    output_path.parent.mkdir(parents=True, exist_ok=True)
    result.save(output_path, optimize=True, quality=92)
    print(f'Saved {output_path}')


if __name__ == '__main__':
    main()
