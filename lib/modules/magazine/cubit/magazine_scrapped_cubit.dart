import 'package:aroundus_app/repositories/magazine_repository/magazine_repository.dart';
import 'package:aroundus_app/repositories/magazine_repository/models/models.dart';
import 'package:aroundus_app/support/base_component/base_component.dart';
import 'package:aroundus_app/support/networks/api_result.dart';
import 'package:aroundus_app/support/networks/network_exceptions.dart';
import 'package:aroundus_app/support/networks/page_response.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'magazine_scrapped_state.dart';

class MagazineScrappedCubit extends Cubit<MagazineScrappedState> {
  MagazineScrappedCubit(this._magazineRepository)
      : super(const MagazineScrappedState(
          isLoading: true,
          isLoaded: false,
          maxIndex: false,
          page: 1,
        ));

  final MagazineRepository _magazineRepository;

  Future<void> getScrappedMagazine() async {
    if (!state.maxIndex) {
      ApiResult<PageResponse> apiResult =
          await _magazineRepository.getScrappedMagazine(state.page);

      apiResult.when(success: (PageResponse? pageResponse) {
        List<Magazine>? newMagazine =
            pageResponse!.results?.map((e) => Magazine.fromJson(e)).toList();

        emit(state.copyWith(
          scrappedMagazines: state.scrappedMagazines != null
              ? state.scrappedMagazines! + newMagazine!
              : newMagazine!,
          isLoaded: true,
          isLoading: false,
          page: state.page + 1,
          next: pageResponse.next,
          previous: pageResponse.previous,
          maxIndex: pageResponse.next == null ? true : false,
        ));
      }, failure: (NetworkExceptions? error) {
        logger.w("error $error!");
        emit(state.copyWith(error: error));
      });
    }
  }
}
