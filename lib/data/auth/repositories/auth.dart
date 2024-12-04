import 'package:dartz/dartz.dart';
import 'package:ecommers/data/auth/model/user.dart';
import 'package:ecommers/data/auth/model/user_creation_req.dart';
import 'package:ecommers/data/auth/model/user_signin_request.dart';
import 'package:ecommers/data/auth/sources/firebase_auth_service.dart';
import 'package:ecommers/domain/auth/repositories/auth.dart';
import 'package:ecommers/service_locator.dart';

class AuthRepositoryImpl extends AuthRepository {
  @override
  Future<Either> signup(UserCreationReq userCreationReq) {
    return sl<AuthFirebaseService>().signup(userCreationReq);
  }

  @override
  Future<Either> getAges() {
    return sl<AuthFirebaseService>().getAges();
  }

  @override
  Future<Either> signIn(UserSignInReq userSignInReq) {
    return sl<AuthFirebaseService>().signIn(userSignInReq);
  }

  @override
  Future<Either> sendPasswordResetEmail(String email) {
    return sl<AuthFirebaseService>().sendPasswordResetEmail(email);
  }

  @override
  Future<bool> isLoggedIn() {
    return sl<AuthFirebaseService>().isLoggedIn();
  }

  @override
  Future<Either> getUser() async {
    var user = await sl<AuthFirebaseService>().getUser();

    return user.fold((error) => Left(error),
        (data) => Right(UserModel.fromJson(data).toEntity()));
  }
}
