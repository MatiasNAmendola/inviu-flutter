import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:inviu_flutter/domain/auth/auth_failure.dart';
import 'package:inviu_flutter/domain/auth/i_auth_facade.dart';
import 'package:inviu_flutter/domain/auth/value_objects.dart';

@prod
@lazySingleton
@RegisterAs(IAuthFacade)
class AuthFacade implements IAuthFacade {
  @override
  Future<Either<AuthFailure, Unit>> register({
    @required EmailAddress emailAddress,
    @required Password password,
  }) async {
    final emailAddressStr = emailAddress.value.getOrElse(() => 'INVALID EMAIL');
    final passwordStr = password.value.getOrElse(() => 'INVALID PASSWORD');
    try {
      return await http.post(
          'https://api-mobile.prod.inviu.com.ar/v1.0/auth/sign-up',
          body: {
            'email': emailAddressStr,
            'password': passwordStr
          }).then((_) => right(unit));
    } on PlatformException catch (e) {
      if (e.code == 'ERROR_EMAIL_ALREADY_IN_USE') {
        return left(const AuthFailure.emailAlreadyInUse());
      } else {
        return left(const AuthFailure.serverError());
      }
    }
  }

  @override
  Future<Either<AuthFailure, Unit>> signIn({
    @required EmailAddress emailAddress,
    @required Password password,
  }) async {
    final emailAddressStr = emailAddress.value.getOrElse(() => 'INVALID EMAIL');
    final passwordStr = password.value.getOrElse(() => 'INVALID PASSWORD');
    try {
      await http
          .post('https://api-mobile.prod.inviu.com.ar/v1.0/auth/login',
              headers: <String, String>{
                'Content-Type': 'application/json; charset=UTF-8',
              },
              body: jsonEncode(<String, String>{
                'email': emailAddressStr,
                'password': passwordStr
              }))
          .then((_) => right(unit));
    } on PlatformException catch (e) {
      if (e.code == 'ERROR_WRONG_PASSWORD' ||
          e.code == 'ERROR_USER_NOT_FOUND') {
        return left(const AuthFailure.invalidEmailAndPasswordCombination());
      }
      return left(const AuthFailure.serverError());
    }
  }
}
