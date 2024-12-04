import 'package:dartz/dartz.dart';
import 'package:ecommers/data/order/models/add_to_card.dart';
import 'package:ecommers/data/order/models/order_model.dart';
import 'package:ecommers/data/order/models/order_regestration_req.dart';
import 'package:ecommers/data/order/models/product_order.dart';
import 'package:ecommers/data/order/sources/order_firebase_service.dart';
import 'package:ecommers/domain/order/repositories/order.dart';
import 'package:ecommers/service_locator.dart';

class OrderRepositoryImpl extends OrderRepository{
  @override
  Future<Either> addToCart(AddToCartReq addToCartReq) {
    return sl<OrderFirebaseService>().addToCart(addToCartReq);
  }

  @override
  Future<Either> getCartProducts() async {
    var returnedData = await sl<OrderFirebaseService>().getCartProducts();
    return returnedData.fold(
            (error){
          return Left(error);
        },
            (data){
          return Right(
              List.from(data).map((e) => ProductOrderedModel.fromMap(e).toEntity()).toList()
          );
        }
    );
  }

  @override
  Future<Either> removeCartProducts(String id){
  return sl<OrderFirebaseService>().removeCartProducts(id);
  }

  @override
  Future<Either> orderRegistration(OrderRegistrationReq orderRegistrationReq) async{
    var returnedData= await sl<OrderFirebaseService>().orderRegistration(orderRegistrationReq);
    return returnedData.fold(
            (error){
          return Left(error);
        },
            (message){
          return Right(
            message

          );
        }
    );
  }

  @override
  Future<Either> getOrders() async{
    var returnedData = await sl<OrderFirebaseService>().getOrders();
    return returnedData.fold(
            (error){
          return Left(error);
        },
            (data){
          return Right(
              List.from(data).map((e) => OrderModel.fromMap(e).toEntity()).toList()
          );
        }
    );
  }

}