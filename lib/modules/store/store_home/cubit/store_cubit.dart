import 'package:aroundus_app/repositories/store_repository/store_repository.dart';
import 'package:aroundus_app/support/networks/api_result.dart';
import 'package:aroundus_app/support/networks/network_exceptions.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'store_state.dart';

class StoreCubit extends Cubit<StoreState> {
  StoreCubit(this._storeRepository) : super(const StoreState());

  final StoreRepository _storeRepository;

  // Future<void> getCollection() async {
  //   ApiResult<List> apiResult = await _storeRepository.getCollection();
  //
  //   apiResult.when(
  //       success: (List? listResponse) {
  //         emit(state.copyWith(
  //           collections: listResponse!.map((e) => Collection.fromJson(e)).toList()
  //         ));
  //       },
  //       failure: (NetworkExceptions? error) {
  //         emit(state.copyWith(error: error));
  //       });
  // }
}
