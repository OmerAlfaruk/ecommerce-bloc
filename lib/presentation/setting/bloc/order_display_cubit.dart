import 'package:bloc/bloc.dart';
import 'package:ecommers/domain/order/usecase/get_order_usecase.dart';
import 'package:ecommers/service_locator.dart';
import 'order_display_state.dart';
class OrderDisplayCubit extends Cubit<OrderDisplayState> {
  OrderDisplayCubit() : super(OrderDisplayLoading());

  void displayOrders()async{
    var returnedData=await sl<GetOrderUseCase>().call();

    returnedData.fold((error){
      emit(OrderDisplayFailure(errorMessage: error));
    }, (orders){
      emit(OrderDisplayLoaded(orders: orders));
    });
  }
}
