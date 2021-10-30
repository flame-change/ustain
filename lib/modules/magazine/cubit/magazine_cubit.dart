import 'package:aroundus_app/repositories/magazine_repository/magazine_repository.dart';
import 'package:aroundus_app/repositories/magazine_repository/models/catalog.dart';
import 'package:aroundus_app/repositories/magazine_repository/models/models.dart';
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
          magazineCategory: MagazineCategory.empty,
          page: 1,
        ));

  final MagazineRepository _magazineRepository;

  Future<void> getMainMagazines() async {
    ApiResult<List> apiResult = await _magazineRepository.getMainMagazine();

    apiResult.when(success: (List? listResponse) {
      emit(state.copyWith(
        todaysMagazines: listResponse!
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

  Future<void> getBannerMagazines() async {
    ApiResult<List> apiResult = await _magazineRepository.getBannerMagazine();

    apiResult.when(success: (List? listResponse) {
      emit(state.copyWith(
        bannerMagazines: listResponse!
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

  Future<void> getCatalogMagazine() async {
    ApiResult<List> apiResult = await _magazineRepository.getCatalogMagazine();

    apiResult.when(success: (List? listResponse) {
      emit(state.copyWith(
        catalogMagazines: listResponse!
            .map((response) => Catalog.fromJson(response!))
            .toList(),
        isLoaded: true,
        isLoading: false,
      ));
    }, failure: (NetworkExceptions? error) {
      logger.w("error $error!");
      emit(state.copyWith(error: error));
    });
  }

  Future<void> getCatalogMagazineDetail(int id) async {
    ApiResult<Catalog> apiResult =
        await _magazineRepository.getCatalogMagazineDetail(id);

    apiResult.when(success: (Catalog? catalog) {
      emit(state.copyWith(
        catalogMagazineDetail: catalog!,
        isLoaded: true,
        isLoading: false,
      ));
    }, failure: (NetworkExceptions? error) {
      logger.w("error $error!");
      emit(state.copyWith(error: error));
    });
  }

  Future<void> getMagazinesByCategory(
      {MagazineCategory? magazineCategory}) async {
    if (state.magazineCategory != magazineCategory) {
      print(
          "state.magazineCategory != magazineCategory ${state.magazineCategory} ${magazineCategory}");
      emit(state.copyWith(
          magazines: [],
          magazineCategory: magazineCategory,
          maxIndex: false,
          page: 1));
    }

    print("state.magazineCategory ${state.magazineCategory}");

    String category = state.magazineCategory == MagazineCategory.empty ||
            magazineCategory == MagazineCategory.empty
        ? ""
        : "\"" + state.magazineCategory!.mid! + "\"";

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
