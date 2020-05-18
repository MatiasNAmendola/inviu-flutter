// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:inviu_flutter/infrastructure/auth/auth_facade.dart';
import 'package:inviu_flutter/domain/auth/i_auth_facade.dart';
import 'package:inviu_flutter/application/auth/sign_in_form/sign_in_form_bloc.dart';
import 'package:inviu_flutter/application/auth/auth_bloc.dart';
import 'package:get_it/get_it.dart';

void $initGetIt(GetIt g, {String environment}) {
  g.registerFactory<SignInFormBloc>(() => SignInFormBloc(g<IAuthFacade>()));
  g.registerFactory<AuthBloc>(() => AuthBloc(g<IAuthFacade>()));

  //Register prod Dependencies --------
  if (environment == 'prod') {
    g.registerLazySingleton<IAuthFacade>(() => AuthFacade());
  }
}
