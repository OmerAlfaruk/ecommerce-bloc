import 'package:ecommers/domain/auth/entities/user.dart';

class UserModel{
  final String userId;
  final String firstName;
  final String lastName;
  final String email;
  final String image;
  final int gender;

  UserModel ({required this.firstName, required this.lastName, required this.email, required this.image, required this.gender,required this.userId});

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'firstName':firstName,
      'lastName': lastName,
      'email': email,
      'image': image,
      'gender': gender,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> data) {
    return UserModel(
      userId: data['userId'],
      firstName: data['firstName'] ,
      lastName: data['lastName'],
      email: data['email'],
      image: data['image']??"" ,
      gender: data['gender'] ,
    );
  }
}
extension UserXModel on UserModel{
  UserEntity toEntity(){
    return UserEntity(firstName: firstName, lastName: lastName, email: email, image: image, gender: gender, userId: userId);
  }
}