part of 'magazine_detail_cubit.dart';

class MagazineDetailState extends Equatable {
  const MagazineDetailState({
    required this.isLoaded,
    required this.isLoading,
    this.error,
    this.magazineDetail,
    this.isLike,
    required this.isHide
  });

  final bool isLoading;
  final bool isLoaded;
  final NetworkExceptions? error;
  final MagazineDetail? magazineDetail;
  final bool isHide;
  final bool? isLike;

  @override
  List<Object?> get props => [magazineDetail, error, isLoaded, isLoading, isHide, isLike];

  MagazineDetailState copyWith(
      {MagazineDetail? magazineDetail,
      NetworkExceptions? error,
      bool? isLoading,
      bool? isLoaded,
      bool? isHide,
      bool? isLike,
      }) {
    return MagazineDetailState(
        magazineDetail: magazineDetail ?? this.magazineDetail,
        error: error ?? this.error,
        isLoaded: isLoaded ?? this.isLoaded,
        isLoading: isLoading ?? this.isLoading,
        isHide: isHide ?? this.isHide,
        isLike: isLike ?? this.isLike,
    );
  }
}
