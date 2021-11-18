part of 'search_cubit.dart';

class SearchState extends Equatable {
  const SearchState(
      {required this.isLoaded,
      required this.isLoading,
      this.error,
      this.products,
      this.magazines,
      this.keyword,
      this.brands});

  final bool isLoading, isLoaded;
  final NetworkExceptions? error;
  final List? magazines, products, brands;
  final String? keyword;

  @override
  List<Object?> get props =>
      [error, isLoaded, isLoading, products, magazines, keyword, brands];

  SearchState copyWith(
      {String? keyword,
      List? products,
      List? magazines,
      List? brands,
      NetworkExceptions? error,
      bool? isLoading,
      bool? isLoaded}) {
    return SearchState(
      error: error ?? this.error,
      isLoaded: isLoaded ?? this.isLoaded,
      isLoading: isLoading ?? this.isLoading,
      brands: brands ?? this.brands,
      keyword: keyword ?? this.keyword,
      magazines: magazines ?? this.magazines,
      products: products ?? this.products,
    );
  }
}
