
import 'package:ecommers/domain/auth/usecases/get_user_use_case.dart';
import 'package:ecommers/presentation/home/bloc/display_user_info/user_info_display_state.dart';
import 'package:ecommers/service_locator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserInfoDisplayCubit extends Cubit<UserInfoDisplayState> {
  UserInfoDisplayCubit() : super(UserInfoDisplayLoading());


  void displayUserInfo() async{
    var returnedData=await sl<GetUserUseCase>().call();

    returnedData.fold((error){emit(UserInfoDisplayFailure());}, (data){emit(UserInfoDisplayLoaded(user: data));});

  }
}


