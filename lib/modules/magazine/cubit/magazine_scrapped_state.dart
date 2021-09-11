part of 'magazine_scrapped_cubit.dart';

class MagazineScrappedState extends Equatable {
  const MagazineScrappedState(
      {
      this.scrappedMagazines,
      this.count,
      this.next,
      this.previous,
      this.error,
      required this.page,
      required this.maxIndex,
      required this.isLoaded,
      required this.isLoading});

  final List<Magazine>? scrappedMagazines;
  final NetworkExceptions? error;
  final int? count;
  final String? next;
  final String? previous;
  final int page;
  final bool maxIndex;
  final bool isLoaded;
  final bool isLoading;

  @override
  List<Object?> get props => [
        scrappedMagazines,
        error,
        maxIndex,
        isLoaded,
        isLoading,
        count,
        next,
        previous,
        page,
      ];

  MagazineScrappedState copyWith({
    List<Magazine>? scrappedMagazines,
    int? count,
    String? next,
    String? previous,
    NetworkExceptions? error,
    bool? maxIndex,
    bool? isLoading,
    bool? isLoaded,
    int? page,
  }) {
    return MagazineScrappedState(
        scrappedMagazines: scrappedMagazines ?? this.scrappedMagazines,
        count: count ?? this.count,
        next: next ?? this.next,
        page: page ?? this.page,
        previous: previous ?? this.previous,
        error: error ?? this.error,
        maxIndex: maxIndex ?? this.maxIndex,
        isLoaded: isLoaded ?? this.isLoaded,
        isLoading: isLoading ?? this.isLoading);
  }
}
