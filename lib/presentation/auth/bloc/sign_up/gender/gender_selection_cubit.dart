import 'package:bloc/bloc.dart';

class GenderSelectionCubit extends Cubit<int> {
  GenderSelectionCubit() : super(1);
  int selectIndex=1;

  void selectedGender(int index){
    selectIndex=index;
    emit(index);
  }
}
