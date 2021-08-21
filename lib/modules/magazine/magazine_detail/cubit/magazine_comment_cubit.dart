import 'package:aroundus_app/repositories/magazine_repository/magazine_repository.dart';
import 'package:aroundus_app/repositories/magazine_repository/models/models.dart';
import 'package:aroundus_app/support/base_component/base_component.dart';
import 'package:aroundus_app/support/networks/api_result.dart';
import 'package:aroundus_app/support/networks/network_exceptions.dart';
import 'package:aroundus_app/support/networks/page_response.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'magazine_comment_state.dart';

class MagazineCommentCubit extends Cubit<MagazineCommentState> {
  MagazineCommentCubit(this._magazineRepository)
      : super(const MagazineCommentState(isLoading: true, isLoaded: false));

  final MagazineRepository _magazineRepository;

  Future<void> getMagazineComments(int id) async {
    ApiResult<PageResponse> apiResult =
        await _magazineRepository.getMagazineComments(id);

    apiResult.when(success: (PageResponse? pageResponse) {
      emit(state.copyWith(
          comments: pageResponse!.results
              ?.map((e) => MagazineComment.fromJson(e))
              .toList(),
          count: pageResponse.count,
          next: pageResponse.next,
          previous: pageResponse.previous,
          isLoaded: true,
          isLoading: false));
    }, failure: (NetworkExceptions? error) {
      logger.w("error $error!");
      emit(state.copyWith(error: error));
    });
  }
}
