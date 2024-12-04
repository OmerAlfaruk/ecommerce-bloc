
import 'package:ecommers/data/order/models/product_order.dart';
import 'package:ecommers/domain/order/entities/product_ordered.dart';

class OrderRegistrationReq{

  final List<ProductOrderedEntity> products;
  final String createdDate;
  final String shippingAddress;
  final int itemCount;
  final double totalPrice;

  OrderRegistrationReq( {required this.products, required this.createdDate, required this.itemCount, required this.totalPrice,required this.shippingAddress,});

  Map<String, dynamic> toMap() {
    return {
      'products': products.map((e) => e.fromEntity().toMap()).toList(),
      'createdDate': createdDate,
      'itemCount': itemCount,
      'totalPrice': totalPrice,
      'shippingAddress': shippingAddress,
    };
  }


}