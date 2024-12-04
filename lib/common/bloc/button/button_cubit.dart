import 'package:dartz/dartz.dart';
import 'package:ecommers/common/bloc/button/button_state.dart';
import 'package:ecommers/core/usecase/usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ButtonCubit extends Cubit<ButtonState> {
  ButtonCubit() : super(ButtonInitial());

  Future<void> execute({dynamic params, required UseCase useCase}) async {
    emit(ButtonLoading());

    try {
      Either returnedData = await useCase.call(params: params);

      returnedData.fold((error) {
        emit(ButtonFailure(errorMessage: error));
      }, (data) {
        emit(ButtonSuccess());
      });
    } catch (e) {
      emit(ButtonFailure(errorMessage: e.toString()));
    }
  }
}
