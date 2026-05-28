import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/app_colors.dart';

enum CommunityTab { top, neueste, meine }

extension CommunityTabX on CommunityTab {
  String get label => switch (this) {
    CommunityTab.top => 'Top',
    CommunityTab.neueste => 'Neueste',
    CommunityTab.meine => 'Meine',
  };
}

class CommunityComment {
  const CommunityComment({
    required this.id,
    required this.name,
    required this.text,
    required this.timeLabel,
    required this.likes,
    required this.color,
    required this.isMine,
    required this.reactions,
    this.likedByMe = false,
  });

  final String id;
  final String name;
  final String text;
  final String timeLabel;
  final int likes;
  final Color color;
  final bool isMine;
  final bool likedByMe;
  final Map<String, int> reactions;

  CommunityComment copyWith({
    String? id,
    String? name,
    String? text,
    String? timeLabel,
    int? likes,
    Color? color,
    bool? isMine,
    bool? likedByMe,
    Map<String, int>? reactions,
  }) {
    return CommunityComment(
      id: id ?? this.id,
      name: name ?? this.name,
      text: text ?? this.text,
      timeLabel: timeLabel ?? this.timeLabel,
      likes: likes ?? this.likes,
      color: color ?? this.color,
      isMine: isMine ?? this.isMine,
      likedByMe: likedByMe ?? this.likedByMe,
      reactions: reactions ?? this.reactions,
    );
  }
}

class CommunityState {
  const CommunityState({
    required this.selectedTab,
    required this.comments,
  });

  final CommunityTab selectedTab;
  final List<CommunityComment> comments;

  List<CommunityComment> get visibleComments {
    switch (selectedTab) {
      case CommunityTab.top:
        final sorted = [...comments]..sort((a, b) => b.likes.compareTo(a.likes));
        return sorted;
      case CommunityTab.neueste:
        return comments;
      case CommunityTab.meine:
        return comments.where((item) => item.isMine).toList();
    }
  }

  CommunityState copyWith({
    CommunityTab? selectedTab,
    List<CommunityComment>? comments,
  }) {
    return CommunityState(
      selectedTab: selectedTab ?? this.selectedTab,
      comments: comments ?? this.comments,
    );
  }
}

final communityProvider = NotifierProvider<CommunityNotifier, CommunityState>(
  CommunityNotifier.new,
);

class CommunityNotifier extends Notifier<CommunityState> {
  static const _emojiOptions = ['🔥', '🤯', '🕵️', '❤️'];

  @override
  CommunityState build() {
    return CommunityState(
      selectedTab: CommunityTab.neueste,
      comments: const [
        CommunityComment(
          id: 'c1',
          name: 'KrimiFan83',
          text: 'Spannung pur! Diese Wendung habe ich nicht kommen sehen.',
          timeLabel: 'vor 1 Min.',
          likes: 24,
          color: AppColors.orange,
          isMine: false,
          reactions: {'🔥': 5, '🤯': 2},
        ),
        CommunityComment(
          id: 'c2',
          name: 'TatortQueen',
          text: 'Borowski einfach der Beste!',
          timeLabel: 'vor 3 Min.',
          likes: 18,
          color: AppColors.redSoft,
          isMine: false,
          reactions: {'❤️': 6},
        ),
        CommunityComment(
          id: 'c3',
          name: 'TatortFan_22',
          text: 'Ich tippe auf den Galeristen. Die Blicke waren zu eindeutig.',
          timeLabel: 'vor 4 Min.',
          likes: 12,
          color: AppColors.green,
          isMine: true,
          reactions: {'🕵️': 4},
        ),
      ],
    );
  }

  List<String> get emojiOptions => _emojiOptions;

  void setTab(CommunityTab tab) {
    state = state.copyWith(selectedTab: tab);
  }

  void addComment(String text) {
    final content = text.trim();
    if (content.isEmpty) return;
    final newComment = CommunityComment(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      name: 'TatortFan_22',
      text: content,
      timeLabel: 'gerade eben',
      likes: 0,
      color: AppColors.red,
      isMine: true,
      reactions: const {},
    );
    state = state.copyWith(comments: [newComment, ...state.comments]);
  }

  void toggleLike(String id) {
    final updated = state.comments.map((comment) {
      if (comment.id != id) return comment;
      final nextLiked = !comment.likedByMe;
      return comment.copyWith(
        likedByMe: nextLiked,
        likes: nextLiked ? comment.likes + 1 : (comment.likes - 1).clamp(0, 9999),
      );
    }).toList();
    state = state.copyWith(comments: updated);
  }

  void addReaction({required String id, required String emoji}) {
    final updated = state.comments.map((comment) {
      if (comment.id != id) return comment;
      final nextMap = Map<String, int>.from(comment.reactions);
      nextMap[emoji] = (nextMap[emoji] ?? 0) + 1;
      return comment.copyWith(reactions: nextMap);
    }).toList();
    state = state.copyWith(comments: updated);
  }
}
