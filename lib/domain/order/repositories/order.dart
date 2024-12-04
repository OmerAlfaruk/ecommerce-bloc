import 'package:dartz/dartz.dart';
import 'package:ecommers/data/order/models/add_to_card.dart';
import 'package:ecommers/data/order/models/order_regestration_req.dart';

abstract class OrderRepository{
  Future<Either> addToCart(AddToCartReq addToCartReq);
  Future<Either> getCartProducts();
  Future<Either> removeCartProducts(String id);
  Future<Either> orderRegistration(OrderRegistrationReq orderRegistrationReq);
  Future<Either> getOrders();

}