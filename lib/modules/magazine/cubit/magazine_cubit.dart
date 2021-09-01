import 'package:aroundus_app/repositories/magazine_repository/magazine_repository.dart';
import 'package:aroundus_app/repositories/magazine_repository/models/magazine.dart';
import 'package:aroundus_app/support/base_component/base_component.dart';
import 'package:aroundus_app/support/networks/api_result.dart';
import 'package:aroundus_app/support/networks/network_exceptions.dart';
import 'package:aroundus_app/support/networks/page_response.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'magazine_state.dart';

class MagazineCubit extends Cubit<MagazineState> {
  MagazineCubit(this._magazineRepository)
      : super(const MagazineState(
          isLoading: true,
          isLoaded: false,
          maxIndex: false,
          page: 1,
          magazineCategory: MagazineCategory.all,
        ));

  final MagazineRepository _magazineRepository;

  Future<void> getMainMagazines() async {
    ApiResult<List> apiResult = await _magazineRepository.getMainMagazine();

    apiResult.when(success: (List? listResponse) {
      emit(state.copyWith(
        todaysMaagazines: listResponse!
            .map((response) => Magazine.fromJson(response!))
            .toList(),
        isLoaded: true,
        isLoading: false,
      ));
    }, failure: (NetworkExceptions? error) {
      logger.w("error $error!");
      emit(state.copyWith(error: error));
    });
  }

  Future<void> getMagazinesByCategory({MagazineCategory? magazineCategory}) async {
    if (magazineCategory != null && state.magazineCategory != magazineCategory) {
      emit(state.copyWith(
        magazines: [],
          magazineCategory: magazineCategory, maxIndex: false, page: 1));
    }

    String category = state.magazineCategory.toValue != ""
        ? "\"" + state.magazineCategory.toValue + "\""
        : state.magazineCategory.toValue;

    if (!state.maxIndex) {
      ApiResult<PageResponse> apiResult = await _magazineRepository
          .getMagazinesByCategory(state.page, category);

      apiResult.when(success: (PageResponse? pageResponse) {
        List<Magazine>? newMagazine =
            pageResponse!.results?.map((e) => Magazine.fromJson(e)).toList();

        emit(state.copyWith(
            magazines: state.magazines != null
                ? state.magazines! + newMagazine!
                : newMagazine!,
            count: pageResponse.count,
            page: state.page + 1,
            next: pageResponse.next,
            previous: pageResponse.previous,
            maxIndex: pageResponse.next == null ? true : false,
            isLoaded: true,
            isLoading: false));
      }, failure: (NetworkExceptions? error) {
        logger.w("error $error!");
        emit(state.copyWith(error: error));
      });
    }
  }
}
