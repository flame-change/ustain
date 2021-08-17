part of 'magazine_cubit.dart';

class MagazineState extends Equatable {
  const MagazineState(
      {this.magazines, this.error, required this.isLoaded, required this.isLoading});

  final List<Magazine>? magazines;
  final NetworkExceptions? error;
  final bool isLoaded;
  final bool isLoading;

  @override
  List<Object?> get props => [magazines, error, isLoaded, isLoading];

  MagazineState copyWith(
      {List<Magazine>? magazines,
      NetworkExceptions? error,
      bool? isLoading,
      bool? isLoaded}) {
    return MagazineState(
        magazines: magazines ?? this.magazines,
        error: error ?? this.error,
        isLoaded: isLoaded ?? this.isLoaded,
        isLoading: isLoading ?? this.isLoading);
  }
}
