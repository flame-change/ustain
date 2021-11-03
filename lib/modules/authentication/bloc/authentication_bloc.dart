import 'dart:async';

import 'package:aroundus_app/modules/authentication/authentication.dart';
import 'package:aroundus_app/repositories/authentication_repository/src/authentication_repository.dart';
import 'package:aroundus_app/repositories/user_repository/user_repository.dart';
import 'package:aroundus_app/support/networks/api_result.dart';
import 'package:aroundus_app/support/networks/network_exceptions.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'authentication_event.dart';

part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc({
    required AuthenticationRepository authenticationRepository,
    required UserRepository userRepository,
  })  : _authenticationRepository = authenticationRepository,
        _userRepository = userRepository,
        super(const AuthenticationState.unknown(User.empty)) {
    _authenticationStatusSubscription = _authenticationRepository.status.listen(
      (status) => add(AuthenticationStatusChanged(status)),
    );
  }

  final AuthenticationRepository _authenticationRepository;
  final UserRepository _userRepository;
  late StreamSubscription<AuthenticationStatus>
      _authenticationStatusSubscription;

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if (event is AuthenticationStatusChanged) {
      yield await _mapAuthenticationStatusChangedToState(event);
    } else if (event is AuthenticationUserChanged) {
      yield await _mapAuthenticationUserChangedToState(event.user);
    } else if (event is AuthenticationLogoutRequested) {
      _authenticationRepository.logOut();
    }
  }

  // @override
  // Future<void> close() {
  //   // _authenticationStatusSubscription.cancel();
  //   // _authenticationRepository.dispose();
  //   // return super.close();
  // }

  Future<AuthenticationState> _mapAuthenticationUserChangedToState(
    User user,
  ) async {
    return AuthenticationState.authenticated(
      user,
    );
  }

  Future<AuthenticationState> _mapAuthenticationStatusChangedToState(
    AuthenticationStatusChanged event,
  ) async {
    switch (event.status) {
      case AuthenticationStatus.unknown:
        AuthenticationState? status = await _tryGetUnknownUser();
        return status!;
      case AuthenticationStatus.authenticated:
        AuthenticationState? status = await _tryGetUser();
        return status!;
      default:
        return const AuthenticationState.unauthenticated();
    }
  }

  Future<AuthenticationState?> _tryGetUser() async {
    try {
      ApiResult<User> apiResult = await _userRepository.getUser();
      AuthenticationState authenticationState =
          AuthenticationState.unauthenticated();
      apiResult.when(success: (User? user) {
        if (user!.name == null || user.name!.length < 0) {
          authenticationState = AuthenticationState.profile(user);
        } else {
          authenticationState = AuthenticationState.authenticated(user);
        }
        logger.w(authenticationState);
      }, failure: (NetworkExceptions? error) {
        authenticationState = AuthenticationState.unauthenticated();
      });

      return authenticationState;
    } on Exception {
      _authenticationRepository.logOut();
    }
  }

  Future<AuthenticationState?> _tryGetUnknownUser() async {
    try {
      ApiResult<User> apiResult = await _userRepository.getUnknownUser();
      AuthenticationState authenticationState =
          AuthenticationState.unauthenticated();
      apiResult.when(success: (User? user) {
        authenticationState = AuthenticationState.unknown(user!);
        logger.w(authenticationState);
      }, failure: (NetworkExceptions? error) {
        authenticationState = AuthenticationState.unauthenticated();
      });

      return authenticationState;
    } on Exception {
      _authenticationRepository.logOut();
    }
  }
}
