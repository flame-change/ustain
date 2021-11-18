import 'package:aroundus_app/repositories/search_repository/src/search_repository.dart';
import 'package:aroundus_app/support/base_component/base_component.dart';
import 'package:aroundus_app/support/networks/network_exceptions.dart';
import 'package:aroundus_app/support/networks/page_response.dart';
import 'package:aroundus_app/support/networks/api_result.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit(this._searchRepository)
      : super(const SearchState(isLoading: true, isLoaded: false));

  final SearchRepository _searchRepository;

  Future<void> search(String keyword, int page) async {
    ApiResult<PageResponse> apiResult =
        await _searchRepository.search(keyword, page);

    apiResult.when(success: (PageResponse? pageResponse) {
      emit(state.copyWith(isLoaded: true, isLoading: false));
    }, failure: (NetworkExceptions? error) {
      logger.w("error $error!");
      emit(state.copyWith(error: error));
    });
  }
}
