import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:inviu_flutter/domain/auth/auth_failure.dart';
import 'package:inviu_flutter/domain/auth/user.dart';
import 'package:inviu_flutter/domain/auth/value_objects.dart';

abstract class IAuthFacade {
  Future<Option<User>> getSignedInUser();
  Future<Either<AuthFailure, Unit>> register({
    @required EmailAddress emailAddress,
    @required Password password,
  });
  Future<Either<AuthFailure, Unit>> signIn({
    @required EmailAddress emailAddress,
    @required Password password,
  });
  Future<void> signOut();
}
