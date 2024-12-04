import 'package:ecommers/common/bloc/product/product_state.dart';
import 'package:ecommers/core/usecase/usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDisplayCubit extends Cubit<ProductDisplayState> {

  final UseCase useCase;
  ProductDisplayCubit({required this.useCase}) : super(ProductInitial());

  void displayProduct({dynamic params}) async {
    print("Fetching products with params: $params");
    emit(ProductLoading());
    try {
      var returnedData = await useCase.call(params: params);
      print("UseCase returned: $returnedData");

      returnedData.fold(
            (error) {
          print("Cubit Error: $error"); // Log the error
          emit(ProductLoadFailure());
        },
            (data) {
          print("Cubit Data: $data"); // Log the data
          emit(ProductLoaded(product: data));
        },
      );
    } catch (e) {
      print("Exception occurred: $e");
      emit(ProductLoadFailure());
    }
  }

  void displayInitial() {
    emit(
        ProductInitial()
    );
  }
}
