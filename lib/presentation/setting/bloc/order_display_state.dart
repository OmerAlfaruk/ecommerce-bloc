import 'package:ecommers/domain/order/entities/order.dart';

class OrderDisplayState {}

class OrderDisplayLoading extends OrderDisplayState {

}
class OrderDisplayLoaded extends OrderDisplayState {
 final List<OrderEntity> orders;

  OrderDisplayLoaded({required this.orders});

}
class OrderDisplayFailure extends OrderDisplayState {
  final String errorMessage;

  OrderDisplayFailure({required this.errorMessage});

}
