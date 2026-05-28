import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/app_colors.dart';

const _avatarColors = [
  AppColors.red,
  AppColors.orange,
  AppColors.green,
  AppColors.redSoft,
  AppColors.yellow,
  AppColors.greenSoft,
  Color(0xFF6B4BCE),
  Color(0xFF4AA0C8),
  Color(0xFFB88856),
  Color(0xFFD67BB6),
];

Color _colorForName(String name) {
  return _avatarColors[name.hashCode.abs() % _avatarColors.length];
}

const _reactionEmojis = ['🔥', '😂', '😮', '❤️', '👍', '💡', '👀'];

String _timeLabel(DateTime dt) {
  final diff = DateTime.now().difference(dt);
  if (diff.inSeconds < 60) return 'jetzt';
  if (diff.inMinutes < 60) return 'vor ${diff.inMinutes} Min.';
  if (diff.inHours < 24) return 'vor ${diff.inHours} Std.';
  return 'vor ${diff.inDays} Tagen';
}

enum CommunityTab { top, newest, mine }

extension CommunityTabX on CommunityTab {
  String get label => switch (this) {
    CommunityTab.top => 'Top',
    CommunityTab.newest => 'Neueste',
    CommunityTab.mine => 'Meine',
  };
}

class CommunityComment {
  CommunityComment({
    required this.id,
    required this.name,
    required this.text,
    this.likes = 0,
    this.likedByMe = false,
    this.reactions = const {},
    DateTime? timestamp,
    Color? color,
  })  : timestamp = timestamp ?? DateTime.now(),
        color = color ?? _colorForName(name);

  final String id;
  final String name;
  final String text;
  final int likes;
  final bool likedByMe;
  final Map<String, int> reactions;
  final DateTime timestamp;
  final Color color;

  String get timeLabel => _timeLabel(timestamp);

  CommunityComment copyWith({
    int? likes,
    bool? likedByMe,
    Map<String, int>? reactions,
  }) {
    return CommunityComment(
      id: id,
      name: name,
      text: text,
      likes: likes ?? this.likes,
      likedByMe: likedByMe ?? this.likedByMe,
      reactions: reactions ?? this.reactions,
      timestamp: timestamp,
      color: color,
    );
  }
}

class CommunityState {
  const CommunityState({
    required this.comments,
    required this.selectedTab,
    required this.currentUserName,
  });

  final List<CommunityComment> comments;
  final CommunityTab selectedTab;
  final String currentUserName;

  List<CommunityComment> get visibleComments {
    switch (selectedTab) {
      case CommunityTab.top:
        final sorted = List<CommunityComment>.from(comments)
          ..sort((a, b) => b.likes.compareTo(a.likes));
        return sorted;
      case CommunityTab.newest:
        final sorted = List<CommunityComment>.from(comments)
          ..sort((a, b) => b.timestamp.compareTo(a.timestamp));
        return sorted;
      case CommunityTab.mine:
        return comments.where((c) => c.name == currentUserName).toList();
    }
  }
}

int _nextCommentId = 100;

const _seedComments = [
  ('KrimiFan83', 'Spannung pur! Diese Wendung habe ich nicht kommen sehen. 😮', 24),
  ('TatortQueen', 'Borowski einfach der Beste! 💙', 18),
  ('Nordlicht', 'Starkes Spiel von den Ermittlern!', 12),
  ('TATORTliebhaber', 'Was haltet ihr von der Tatwaffe?', 7),
  ('Krimi_89', 'Mega Folge bisher! 🔥', 6),
  ('Ermittlerin_01', 'Die Kameraführung in der letzten Szene war ein Meisterwerk 🎬', 15),
  ('Nachtfalke', 'Habe eine Theorie: Der Gärtner war es!', 9),
  ('Herzzeuge', 'Ich kann nicht mehr hinsehen! So spannend! 😱', 21),
  ('Aktenkind', 'Notiz an mich: Unbedingt die erste Staffel nachholen 📝', 4),
  ('KommissarX', 'Die Musikuntermalung ist heute besonders gut gewählt', 11),
  ('Spoilerfrei', 'Noch 20 Minuten – da kommt bestimmt der große Twist!', 8),
  ('TrueCrimeLover', 'Basierend auf einem echten Fall? Weiß das jemand?', 5),
  ('MedienMieze', 'Die Ausstattung der Wohnung ist der Hammer!', 3),
  ('BettBeste', 'Heute allein zu Hause – Tatort-Liebe ist meine Begleitung 🛋️', 16),
  ('ErmittlerElla', 'Der Kommissar hat heute einen guten Tag!', 10),
  ('FilmFuchs', 'Achtung, kleine Anspielung auf Folge 42! Wer hat‘s gesehen?', 13),
  ('CouchPotato', 'Noch eine Tüte Chips und der Abend ist perfekt 🍿', 7),
  ('Mordsspaß', 'Ich tippe auf die Ehefrau!', 19),
  ('LichtAus', 'Warum macht der Zeuge so einen nervösen Eindruck?', 6),
  ('TVJunkie', 'Endlich mal wieder ein starker Tatort aus Kiel!', 5),
];

final communityProvider = NotifierProvider<CommunityNotifier, CommunityState>(
  CommunityNotifier.new,
);

class CommunityNotifier extends Notifier<CommunityState> {
  @override
  CommunityState build() {
    final now = DateTime.now();
    final comments = _seedComments.asMap().entries.map((e) {
      return CommunityComment(
        id: 'seed_${e.key}',
        name: e.value.$1,
        text: e.value.$2,
        likes: e.value.$3,
        timestamp: now.subtract(Duration(minutes: e.key * 3 + 1)),
      );
    }).toList();

    return CommunityState(
      comments: comments,
      selectedTab: CommunityTab.newest,
      currentUserName: 'TatortFan_22',
    );
  }

  void setTab(CommunityTab tab) {
    state = CommunityState(
      comments: state.comments,
      selectedTab: tab,
      currentUserName: state.currentUserName,
    );
  }

  void addComment(String text) {
    if (text.trim().isEmpty) return;
    final comment = CommunityComment(
      id: 'post_${_nextCommentId++}',
      name: state.currentUserName,
      text: text.trim(),
      timestamp: DateTime.now(),
    );
    state = CommunityState(
      comments: [comment, ...state.comments],
      selectedTab: CommunityTab.newest,
      currentUserName: state.currentUserName,
    );
  }

  void deleteComment(String id) {
    state = CommunityState(
      comments: state.comments.where((c) => c.id != id).toList(),
      selectedTab: state.selectedTab,
      currentUserName: state.currentUserName,
    );
  }

  void toggleLike(String id) {
    final updated = state.comments.map((c) {
      if (c.id != id) return c;
      return c.copyWith(
        likes: c.likedByMe ? c.likes - 1 : c.likes + 1,
        likedByMe: !c.likedByMe,
      );
    }).toList();
    state = CommunityState(
      comments: updated,
      selectedTab: state.selectedTab,
      currentUserName: state.currentUserName,
    );
  }

  void addReaction({required String id, required String emoji}) {
    final updated = state.comments.map((c) {
      if (c.id != id) return c;
      final reactions = Map<String, int>.from(c.reactions);
      reactions[emoji] = (reactions[emoji] ?? 0) + 1;
      return c.copyWith(reactions: reactions);
    }).toList();
    state = CommunityState(
      comments: updated,
      selectedTab: state.selectedTab,
      currentUserName: state.currentUserName,
    );
  }

  List<String> get emojiOptions => _reactionEmojis;
}

final availableReactionsProvider = Provider<List<String>>((ref) {
  return _reactionEmojis;
});
