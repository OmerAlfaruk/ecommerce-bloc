import 'package:dartz/dartz.dart';
import 'package:ecommers/core/usecase/usecase.dart';
import 'package:ecommers/domain/order/repositories/order.dart';
import 'package:ecommers/service_locator.dart';

class RemoveCartOrderUseCase extends UseCase<Either,String>{
  @override
  Future<Either> call({String? params}) {
    return sl<OrderRepository>().removeCartProducts(params!);
  }

}