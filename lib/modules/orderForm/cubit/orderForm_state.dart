part of 'orderForm_cubit.dart';

class OrderFormState extends Equatable {
  const OrderFormState({
    this.orderForm,
    this.isLoaded = false,
    this.isLoading = true,
    this.error,
    this.errorMessage,
  });

  final Map? orderForm;
  final bool isLoaded;
  final bool isLoading;
  final NetworkExceptions? error;
  final String? errorMessage;

  @override
  List<Object?> get props => [
        orderForm,
        isLoaded,
        isLoading,
        error,
        errorMessage,
      ];

  OrderFormState copyWith({
    Map? orderForm,
    NetworkExceptions? error,
    bool? isLoading,
    bool? isLoaded,
    String? errorMessage,
  }) {
    return OrderFormState(
      orderForm: orderForm ?? this.orderForm,
      error: error ?? this.error,
      isLoading: isLoading ?? this.isLoading,
      isLoaded: isLoaded ?? this.isLoaded,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
