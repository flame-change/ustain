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

  Future<void> requestMagazineComment(
      int magazineId, String replyContent, int? replyId) async {
    Map<String, dynamic> body = {
      "content": replyContent,
      "magazines": magazineId,
      "parent": replyId
    };
    ApiResult<Map> apiResult =
        await _magazineRepository.requestMagazineComment(body);

    apiResult.when(success: (Map? mapResponse) {
      MagazineComment newComment =
          MagazineComment.fromJson(mapResponse!["data"]);
      List<MagazineComment> comments;

      if (replyId == null) {
        // 댓글인 경우 (답글 X)
        comments = state.comments! + [newComment];
      } else {
        // 답글인 경우
        print("답글");

        comments = state.comments!
            .map((comment) => comment.id == replyId
                ? comment.copyWith(reply: comment.reply==null?[]:comment.reply! + [newComment])
                : comment)
            .toList();
      }

      emit(state.copyWith(comments: comments));
    }, failure: (NetworkExceptions? error) {
      logger.w("error $error!");
      emit(state.copyWith(error: error));
    });
  }

  Future<void> deleteMagazineComment(MagazineComment deleteComment) async {
    ApiResult<Map> apiResult =
        await _magazineRepository.deleteMagazineComment(deleteComment.id!);

    apiResult.when(success: (Map? mapResponse) {
      List<MagazineComment>? comments;

      // 삭제하려는 댓글이 답글이 아닌 경우
      if (state.comments!.contains(deleteComment)) {
        comments = state.comments!.map((e) => e.copyWith()).toList();
        comments.remove(deleteComment);
      } else {
        // 삭제하려는 댓글이 답글인 경우
        comments = state.comments!
            .map((comment) => comment.reply!.indexOf(deleteComment) != -1
                ? comment.reply!.removeAt(comment.reply!.indexOf(deleteComment))
                : comment)
            .toList();
      }
      emit(state.copyWith(comments: comments));
    }, failure: (NetworkExceptions? error) {
      logger.w("error $error!");
      emit(state.copyWith(error: error));
    });
  }

/* 댓글 편집 기능 보류
  Future<void> updateMagazineComment(int magazineId, String content) async {
    ApiResult<Map> apiResult =
        await _magazineRepository.updateMagazineComment(magazineId, content);

    apiResult.when(success: (Map? mapResponse) {
      emit(state.copyWith(
          // comments:
          ));
    }, failure: (NetworkExceptions? error) {
      logger.w("error $error!");
      emit(state.copyWith(error: error));
    });
  }
   */
}
