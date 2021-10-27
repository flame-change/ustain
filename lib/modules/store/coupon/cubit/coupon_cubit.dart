import 'package:aroundus_app/repositories/coupon_repository/coupon_repository.dart';
import 'package:aroundus_app/repositories/coupon_repository/models/coupon.dart';
import 'package:aroundus_app/support/networks/api_result.dart';
import 'package:aroundus_app/support/networks/network_exceptions.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'coupon_state.dart';

class CouponCubit extends Cubit<CouponState> {
  CouponCubit(this._couponRepository) : super(const CouponState());

  final CouponRepository _couponRepository;

  Future<void> getCouponList() async {
    ApiResult<List> apiResult = await _couponRepository.getCouponList();

    apiResult.when(success: (List? listResponse) {
      emit(state.copyWith(
        coupons:
            listResponse!.map((coupon) => Coupon.fromJson(coupon)).toList(),
        isLoading: false,
        isLoaded: true,
      ));
    }, failure: (NetworkExceptions? error) {
      emit(state.copyWith(error: error));
    });
  }
}
