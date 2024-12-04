import 'package:dartz/dartz.dart';
import 'package:ecommers/data/auth/model/user_creation_req.dart';
import 'package:ecommers/data/auth/model/user_signin_request.dart';

abstract class AuthRepository{
  Future<Either> signup(UserCreationReq userCreationReq);
  Future<Either> signIn(UserSignInReq userSignInReq);
  Future<Either> getAges();
  Future<Either> sendPasswordResetEmail(String email);

  Future<Either> getUser();
  Future<bool> isLoggedIn();
}