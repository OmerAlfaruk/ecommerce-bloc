import 'package:bloc/bloc.dart';
import 'package:ecommers/domain/order/entities/product_ordered.dart';
import 'package:ecommers/domain/order/usecase/get_cart_product.dart';
import 'package:ecommers/domain/order/usecase/remove_cart_order_usecase.dart';

import '../../../service_locator.dart';
import 'cart_products_display_state.dart';

class CartProductsDisplayCubit extends Cubit<CartProductsDisplayState> {
  CartProductsDisplayCubit() : super(CartProductsLoading());


  void displayCartProducts() async {

    var returnedData = await sl<GetCartProductUseCase>().call();

    returnedData.fold(
            (error) {
          emit(CartProductsFailure(errorMessage: error));
        },
            (data) {
          emit(CartProductsLoaded(products: data));
        }
    );
  }

  void removeCartProduct(String id)async{
    emit(CartProductsLoading());
    var returnedData = await sl<RemoveCartOrderUseCase>().call(params: id);
    returnedData.fold(
            (error) {
          emit(CartProductsFailure(errorMessage: error));
        },
            (data) {
          displayCartProducts();
        }
    );
  }
  }


