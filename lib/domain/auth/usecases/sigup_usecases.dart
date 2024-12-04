import 'package:dartz/dartz.dart';
import 'package:ecommers/core/usecase/usecase.dart';
import 'package:ecommers/data/auth/model/user_creation_req.dart';
import 'package:ecommers/domain/auth/repositories/auth.dart';
import 'package:ecommers/service_locator.dart';

class SignupUseCase extends UseCase<Either,UserCreationReq?>{
  @override
  Future<Either> call({params}) {
  return sl<AuthRepository>().signup(params!);
  }

}