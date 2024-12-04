import 'package:ecommers/domain/order/entities/product_ordered.dart';

abstract class CartProductsDisplayState {}

class CartProductsLoading extends CartProductsDisplayState {}
class CartProductsLoaded extends CartProductsDisplayState {
  final List<ProductOrderedEntity> products;

  CartProductsLoaded({required this.products});

}
class CartProductsFailure extends CartProductsDisplayState {
  final String errorMessage;

  CartProductsFailure({required this.errorMessage});
}
