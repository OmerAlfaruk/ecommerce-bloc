
import 'package:ecommers/domain/category/usecases/get_category_use_case.dart';
import 'package:ecommers/service_locator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'categories_display_state.dart';

class CategoriesDisplayCubit extends Cubit<CategoriesDisplayState> {
  CategoriesDisplayCubit() : super(CategoriesLoading());



  void displayCategories() async{
    var returnedData=await sl<GetCategoryUseCase>().call();
    returnedData.fold((error){
      emit(CategoriesFailure());
    }, (data){
      emit(CategoriesLoaded(categories: data));
    });
  }
}
