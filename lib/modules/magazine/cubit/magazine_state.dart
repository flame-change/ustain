part of 'magazine_cubit.dart';

class MagazineState extends Equatable {
  const MagazineState(
      {this.todaysMagazines,
      this.bannerMagazines,
      this.catalogMagazines,
      this.catalogMagazineDetail,
      this.magazines,
      this.magazineCategory,
      this.count,
      this.next,
      this.previous,
      this.error,
      required this.page,
      required this.maxIndex,
      required this.isLoaded,
      required this.isLoading});

  final List<Magazine>? todaysMagazines;
  final List<Magazine>? bannerMagazines;
  final List<Catalog>? catalogMagazines;
  final Catalog? catalogMagazineDetail;
  final List<Magazine>? magazines;
  final NetworkExceptions? error;
  final MagazineCategory? magazineCategory;
  final int? count;
  final String? next;
  final String? previous;
  final int page;
  final bool maxIndex;
  final bool isLoaded;
  final bool isLoading;

  @override
  List<Object?> get props => [
        todaysMagazines,
        bannerMagazines,
        catalogMagazines,
        catalogMagazineDetail,
        magazines,
        magazineCategory,
        error,
        maxIndex,
        isLoaded,
        isLoading,
        count,
        next,
        previous,
        page,
      ];

  MagazineState copyWith({
    List<Magazine>? todaysMagazines,
    List<Magazine>? bannerMagazines,
    List<Catalog>? catalogMagazines,
    Catalog? catalogMagazineDetail,
    List<Magazine>? magazines,
    MagazineCategory? magazineCategory,
    int? count,
    String? next,
    String? previous,
    NetworkExceptions? error,
    bool? maxIndex,
    bool? isLoading,
    bool? isLoaded,
    int? page,
  }) {
    return MagazineState(
        todaysMagazines: todaysMagazines ?? this.todaysMagazines,
        bannerMagazines: bannerMagazines ?? this.bannerMagazines,
        catalogMagazines: catalogMagazines ?? this.catalogMagazines,
        catalogMagazineDetail:
            catalogMagazineDetail ?? this.catalogMagazineDetail,
        magazines: magazines ?? this.magazines,
        magazineCategory: magazineCategory ?? this.magazineCategory,
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
