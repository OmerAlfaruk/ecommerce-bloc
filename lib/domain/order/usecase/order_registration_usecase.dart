import 'package:dartz/dartz.dart';
import 'package:ecommers/core/usecase/usecase.dart';
import 'package:ecommers/data/order/models/order_regestration_req.dart';
import 'package:ecommers/domain/auth/entities/user.dart';
import 'package:ecommers/domain/order/repositories/order.dart';
import 'package:ecommers/service_locator.dart';

class OrderRegistrationUseCase extends UseCase<Either,OrderRegistrationReq>{
  @override
  Future<Either> call({OrderRegistrationReq? params}) {
return sl<OrderRepository>().orderRegistration(params!);
  }

}