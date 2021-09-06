part of 'store_cubit.dart';

class StoreState extends Equatable {
  const StoreState({
    required this.isLoading,
    required this.isLoaded,
  });

  final bool isLoading;
  final bool isLoaded;

  @override
  List<Object?> get props => [
        isLoaded,
        isLoading,
      ];

  StoreState copyWith({
    bool? isLoading,
    bool? isLoaded,
  }) {
    return StoreState(
      isLoading: isLoading ?? this.isLoading,
      isLoaded: isLoaded ?? this.isLoaded,
    );
  }
}
