part of 'order_cubit.dart';

class OrderState extends Equatable {
  const OrderState({
    this.order,
    this.error,
    this.isLoaded = false,
    this.isLoading = true,
    this.errorMessage,
  });

  final Order? order;
  final bool isLoaded;
  final bool isLoading;
  final NetworkExceptions? error;
  final String? errorMessage;

  @override
  List<Object?> get props => [
        order,
        error,
        isLoaded,
        isLoading,
        errorMessage,
      ];

  OrderState copyWith({
    Order? order,
    NetworkExceptions? error,
    bool? isLoading,
    bool? isLoaded,
    String? errorMessage,
  }) {
    return OrderState(
      order: order ?? this.order,
      error: error ?? this.error,
      isLoading: isLoading ?? this.isLoading,
      isLoaded: isLoaded ?? this.isLoaded,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
