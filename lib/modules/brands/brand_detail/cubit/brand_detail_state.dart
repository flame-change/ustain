part of 'brand_detail_cubit.dart';

class BrandDetailState extends Equatable {
  const BrandDetailState(
      {required this.isLoaded,
      required this.isLoading,
      this.error,
      this.brandDetail});

  final bool isLoading;
  final bool isLoaded;
  final NetworkExceptions? error;
  final BrandDetail? brandDetail;

  @override
  List<Object?> get props => [brandDetail, error, isLoaded, isLoading];

  BrandDetailState copyWith(
      {BrandDetail? brandDetail,
      NetworkExceptions? error,
      bool? isLoading,
      bool? isLoaded}) {
    return BrandDetailState(
        brandDetail: brandDetail ?? this.brandDetail,
        error: error ?? this.error,
        isLoaded: isLoaded ?? this.isLoaded,
        isLoading: isLoading ?? this.isLoading);
  }
}
