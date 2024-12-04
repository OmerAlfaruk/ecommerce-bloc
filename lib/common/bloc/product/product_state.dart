 import 'package:ecommers/domain/product/entities/color.dart';
import 'package:ecommers/domain/product/entities/product.dart';

class ProductDisplayState {}

class ProductInitial extends ProductDisplayState {}
class ProductLoading extends ProductDisplayState {}
 class ProductLoaded extends ProductDisplayState {
  final List<ProductEntity> product;

  ProductLoaded({required this.product});

 }
 class ProductLoadFailure extends ProductDisplayState {}
