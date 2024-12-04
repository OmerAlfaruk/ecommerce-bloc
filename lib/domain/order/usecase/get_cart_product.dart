import 'package:dartz/dartz.dart';
import 'package:ecommers/core/usecase/usecase.dart';
import 'package:ecommers/data/order/models/add_to_card.dart';
import 'package:ecommers/domain/order/repositories/order.dart';
import 'package:ecommers/service_locator.dart';

class GetCartProductUseCase extends UseCase<Either,dynamic>{
  @override
  Future<Either> call({params}) {
    return sl<OrderRepository>().getCartProducts();
  }

}