
import 'package:ecommers/domain/auth/usecases/get_ages_usecase.dart';
import 'package:ecommers/service_locator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'ages_display_state.dart';

class AgesDisplayCubit extends Cubit<AgesDisplayState> {
  AgesDisplayCubit():super(AgesLoading());

  void displayAges() async{
   var ages= await sl<GetAgesUseCase>().call();

ages.fold((error){
  emit(AgesLoadFailure(message: error));
}, (data){
  emit(AgesLoaded(ages: data));
});

  }
}
