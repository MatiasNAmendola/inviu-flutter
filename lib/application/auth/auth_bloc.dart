import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:inviu_flutter/domain/auth/user.dart';
import 'package:inviu_flutter/domain/auth/i_auth_facade.dart';

part 'auth_event.dart';
part 'auth_state.dart';

part 'auth_bloc.freezed.dart';

@injectable
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final IAuthFacade _authFacade;

  AuthBloc(this._authFacade);

  @override
  AuthState get initialState => const AuthState.initial();

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    yield* event.map(
      authCheckRequested: (e) async* {
        // final userOption = await _authFacade.getSignedInUser();
        // yield userOption.fold(
        //   () => const AuthState.unauthenticated(),
        //   (user) => AuthState.authenticated(user),
        // );
        yield const AuthState.unauthenticated();
      },
      signedOut: (e) async* {
        // await _authFacade.signOut();
        yield const AuthState.unauthenticated();
      },
    );
  }
}
