part of 'product_cubit.dart';

class CartState extends Equatable {
  const CartState({this.error, this.isLoaded = false, this.isLoading = true});

  final bool isLoaded;
  final bool isLoading;
  final NetworkExceptions? error;

  @override
  List<Object?> get props => [
        error,
        isLoaded,
        isLoading,
      ];

  CartState copyWith({
    NetworkExceptions? error,
    bool? isLoading,
    bool? isLoaded,
  }) {
    return CartState(
        error: error ?? this.error,
        isLoaded: isLoaded ?? this.isLoaded,
        isLoading: isLoading ?? this.isLoading);
  }
}
