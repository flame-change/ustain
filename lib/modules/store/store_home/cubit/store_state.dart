part of 'store_cubit.dart';

class StoreState extends Equatable {
  const StoreState({
    this.products,
    this.selectedMenu,
    this.count = 0,
    this.previous,
    this.next,
    this.page = 1,
    this.maxIndex = false,
    this.isLoading = true,
    this.isLoaded = false,
    this.error,
  });

  final List<Product>? products;
  final Collection? selectedMenu;
  final int? count;
  final String? previous;
  final String? next;
  final int? page;
  final bool? maxIndex;
  final bool isLoading;
  final bool isLoaded;
  final NetworkExceptions? error;

  @override
  List<Object?> get props => [
        products,
    selectedMenu,
        count,
        previous,
        next,
        page,
        maxIndex,
        isLoaded,
        isLoading,
        error,
      ];

  StoreState copyWith({
    List<Product>? products,
    Collection? selectedMenu,
    int? count,
    String? previous,
    String? next,
    int? page,
    bool? maxIndex,
    bool? isLoading,
    bool? isLoaded,
    NetworkExceptions? error,
  }) {
    return StoreState(
      products: products ?? this.products,
      selectedMenu: selectedMenu ?? this.selectedMenu,
      count: count ?? this.count,
      previous: previous ?? this.previous,
      next: next ?? this.next,
      page: page ?? this.page,
      maxIndex: maxIndex ?? this.maxIndex,
      isLoading: isLoading ?? this.isLoading,
      isLoaded: isLoaded ?? this.isLoaded,
      error: error ?? this.error,
    );
  }
}
