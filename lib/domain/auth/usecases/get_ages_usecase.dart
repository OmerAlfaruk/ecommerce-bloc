import 'package:dartz/dartz.dart';
import 'package:ecommers/core/usecase/usecase.dart';
import 'package:ecommers/domain/auth/repositories/auth.dart';
import 'package:ecommers/service_locator.dart';

class GetAgesUseCase implements UseCase<Either,dynamic>{
  @override
  Future<Either> call({ dynamic params})async {
    return await sl<AuthRepository>().getAges();
  }

}