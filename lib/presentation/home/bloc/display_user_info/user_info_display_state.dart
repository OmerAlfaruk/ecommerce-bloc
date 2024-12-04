 import 'package:ecommers/domain/auth/entities/user.dart';

class UserInfoDisplayState {}

 class UserInfoDisplayLoading extends UserInfoDisplayState {}
 class UserInfoDisplayLoaded extends UserInfoDisplayState {

 final UserEntity user;

  UserInfoDisplayLoaded({required this.user});
 }
 class UserInfoDisplayFailure extends UserInfoDisplayState {}
