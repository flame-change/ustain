part of 'magazine_detail_cubit.dart';

class MagazineDetailState extends Equatable {
  const MagazineDetailState({
    required this.isLoaded,
    required this.isLoading,
    this.error,
    this.magazineDetail,
  });

  final bool isLoading;
  final bool isLoaded;
  final NetworkExceptions? error;
  final MagazineDetail? magazineDetail;

  @override
  List<Object?> get props => [magazineDetail, error, isLoaded, isLoading];

  MagazineDetailState copyWith(
      {MagazineDetail? magazineDetail,
      NetworkExceptions? error,
      bool? isLoading,
      bool? isLoaded}) {
    return MagazineDetailState(
        magazineDetail: magazineDetail ?? this.magazineDetail,
        error: error ?? this.error,
        isLoaded: isLoaded ?? this.isLoaded,
        isLoading: isLoading ?? this.isLoading);
  }
}
