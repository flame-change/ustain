import 'package:aroundus_app/modules/authentication/account/cubit/finding_account_cubit.dart';
import 'package:aroundus_app/repositories/address_repository/src/address_repository.dart';
import 'package:aroundus_app/repositories/magazine_repository/magazine_repository.dart';
import 'package:aroundus_app/repositories/search_repository/src/search_repository.dart';
import 'package:aroundus_app/repositories/brand_repository/src/brand_repository.dart';
import 'package:aroundus_app/repositories/order_repository/src/order_repository.dart';
import 'package:aroundus_app/repositories/user_repository/src/user_repository.dart';
import 'package:aroundus_app/repositories/coupon_repository/coupon_repository.dart';
import 'package:aroundus_app/repositories/cart_repository/cart_repository.dart';
import 'modules/authentication/signup/cubit/signup_cubit.dart';
import 'package:aroundus_app/support/networks/dio_client.dart';
import 'modules/authentication/bloc/authentication_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'repositories/repositories.dart';
import 'app_view.dart';


class App extends StatelessWidget {
  const App({
    required this.authenticationRepository,
    required this.dioClient,
  });

  final AuthenticationRepository authenticationRepository;
  final DioClient dioClient;

  @override
  Widget build(BuildContext context) {
    final UserRepository userRepository = UserRepository(dioClient);

    return MultiRepositoryProvider(
        providers: [
          RepositoryProvider<AuthenticationRepository>(
              create: (context) => authenticationRepository),
          RepositoryProvider(
              create: (context) => MagazineRepository(dioClient)),
          RepositoryProvider(
              create: (context) => UserRepository(dioClient)),
          RepositoryProvider(create: (context) => ProductRepository(dioClient)),
          RepositoryProvider(create: (context) => StoreRepository(dioClient)),
          RepositoryProvider(create: (context) => CartRepository(dioClient)),
          RepositoryProvider(create: (context) => OrderRepository(dioClient)),
          RepositoryProvider(create: (context) => AddressRepository(dioClient)),
          RepositoryProvider(create: (context) => CouponRepository(dioClient)),
          RepositoryProvider(create: (context) => BrandRepository(dioClient)),
          RepositoryProvider(create: (context) => SearchRepository(dioClient)),
        ],
        child: MultiBlocProvider(providers: [
          BlocProvider<AuthenticationBloc>(
              create: (context) => AuthenticationBloc(
                  authenticationRepository: authenticationRepository,
                  userRepository: userRepository)),
          BlocProvider<SignupCubit>(
              create: (context) => SignupCubit(authenticationRepository)),
        ], child: AppView()));
  }
}
