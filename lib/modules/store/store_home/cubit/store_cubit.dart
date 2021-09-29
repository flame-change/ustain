import 'package:aroundus_app/repositories/store_repository/store_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'store_state.dart';

class StoreCubit extends Cubit<StoreState> {
  StoreCubit(this._storeRepository)
      : super(const StoreState(
          isLoading: true,
          isLoaded: false,
        ));

  final StoreRepository _storeRepository;

}
