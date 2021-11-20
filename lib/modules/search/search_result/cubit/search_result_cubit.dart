import 'package:aroundus_app/repositories/search_repository/src/search_repository.dart';
import 'package:aroundus_app/support/base_component/base_component.dart';
import 'package:aroundus_app/support/networks/network_exceptions.dart';
import 'package:aroundus_app/support/networks/page_response.dart';
import 'package:aroundus_app/support/networks/api_result.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
part 'search_result_state.dart';

class SearchResultCubit extends Cubit<SearchResultState> {
  SearchResultCubit(this._searchRepository)
      : super(
            const SearchResultState(isLoading: true, isLoaded: false, page: 1));

  final SearchRepository _searchRepository;

  Future<void> search(String keyword) async {
    ApiResult<PageResponse> apiResult =
        await _searchRepository.search(keyword, state.page!);

    apiResult.when(success: (PageResponse? pageResponse) {
      emit(state.copyWith(isLoaded: true, isLoading: false));
    }, failure: (NetworkExceptions? error) {
      logger.w("error $error!");
      emit(state.copyWith(error: error));
    });
  }
}
