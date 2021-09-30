part of 'store_cubit.dart';

class StoreState extends Equatable {
  const StoreState({
    this.collections,
    this.isLoading = true,
    this.isLoaded = false,
    this.error,
  });

  final List<Collection>? collections;
  final bool isLoading;
  final bool isLoaded;
  final NetworkExceptions? error;

  @override
  List<Object?> get props => [
        collections,
        isLoaded,
        isLoading,
        error,
      ];

  StoreState copyWith({
    List<Collection>? collections,
    bool? isLoading,
    bool? isLoaded,
    NetworkExceptions? error,
  }) {
    return StoreState(
      collections: collections ?? this.collections,
      isLoading: isLoading ?? this.isLoading,
      isLoaded: isLoaded ?? this.isLoaded,
      error: error ?? this.error,
    );
  }
}
