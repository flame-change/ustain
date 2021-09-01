part of 'magazine_comment_cubit.dart';

class MagazineCommentState extends Equatable {
  const MagazineCommentState({
    required this.isLoaded,
    required this.isLoading,
    this.error,
    this.count,
    this.next,
    this.previous,
    this.comments,
  });

  final bool isLoading;
  final bool isLoaded;
  final NetworkExceptions? error;
  final int? count;
  final String? next;
  final String? previous;

  final List<MagazineComment>? comments;

  @override
  List<Object?> get props => [
    error,
    isLoaded,
    isLoading,
    count,
    next,
    previous,
    comments,
  ];

  MagazineCommentState copyWith({
    NetworkExceptions? error,
    bool? isLoading,
    bool? isLoaded,
    int? count,
    String? next,
    String? previous,
    List<MagazineComment>? comments,
  }) {
    return MagazineCommentState(
      error: error ?? this.error,
      isLoaded: isLoaded ?? this.isLoaded,
      isLoading: isLoading ?? this.isLoading,
      count: count ?? this.count,
      next: next ?? this.next,
      previous: previous ?? this.previous,
      comments: comments ?? this.comments,
    );
  }
}
