part of 'magazine_detail_cubit.dart';

class MagazineDetailState extends Equatable {
  const MagazineDetailState({
    required this.isLoaded,
    required this.isLoading,
    this.error,
    this.magazineDetail,
    required this.isHide
  });

  final bool isLoading;
  final bool isLoaded;
  final NetworkExceptions? error;
  final MagazineDetail? magazineDetail;
  final bool isHide;

  @override
  List<Object?> get props => [magazineDetail, error, isLoaded, isLoading, isHide];

  MagazineDetailState copyWith(
      {MagazineDetail? magazineDetail,
      NetworkExceptions? error,
      bool? isLoading,
      bool? isLoaded,
      bool? isHide
      }) {
    return MagazineDetailState(
        magazineDetail: magazineDetail ?? this.magazineDetail,
        error: error ?? this.error,
        isLoaded: isLoaded ?? this.isLoaded,
        isLoading: isLoading ?? this.isLoading,
        isHide: isHide ?? this.isHide
    );
  }
}
