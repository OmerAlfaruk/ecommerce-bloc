import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:ecommers/data/auth/model/user_creation_req.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../model/user_signin_request.dart';

abstract class AuthFirebaseService{
  Future<Either> signup(UserCreationReq userCreationReq);
  Future<Either> getAges();
  Future<Either> signIn(UserSignInReq userSignInReq);
  Future<Either> sendPasswordResetEmail(String email);
  Future<Either> getUser();
  Future<bool> isLoggedIn();
}
class AuthFirebaseServiceImp extends AuthFirebaseService{
  @override
  Future<Either> signup(UserCreationReq userCreationReq) async {
    try {
      var data = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: userCreationReq.email!,
        password: userCreationReq.password!,
      );

      // Use the user's UID as the document ID for better structure
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(data.user?.uid)
          .set({
        'firstName': userCreationReq.firstName ??
            "Unnamed User",
        'lastName': userCreationReq.lastName ??
            "Unnamed User", // Use a default if name is null
        'email': data.user?.email ?? "",
        'gender': userCreationReq.gender ?? 0,
        'age': userCreationReq.age ?? "",
        'userId': data.user!.uid,
        'createdAt': FieldValue.serverTimestamp(),
      });

      return Right(data.user);
    } on FirebaseAuthException catch (e) {
      String message = '';
      if (e.code == 'weak-password') {
        message = 'The password provided is too weak';
      } else if (e.code == 'email-already-in-use') {
        message = 'An account already exists with that email';
      } else {
        message = 'An error occurred: ${e.message}';
      }
      return Left(message);
    } catch (e) {
      // Catch unexpected errors
      return Left('An unexpected error occurred: $e');
    }
  }

  @override
  Future<Either> getAges() async{
    try{
   var returnedData=await FirebaseFirestore.instance.collection('Ages').get();
   return Right(returnedData.docs);
  }catch(e){
      return Left('failed to load ages');
    }

  }

  @override
  Future<Either> signIn(UserSignInReq userSignInReq)async {
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: userSignInReq.email!, password: userSignInReq.password!);
        return const Right("Sign in successful");
      } on FirebaseAuthException catch (e) {
        String message = '';
        if (e.code == 'Invalid-email') {
          message = 'User not found for that email';
        } else if (e.code == 'Invalid-credential') {
          message = 'Wrong password provided';
        }
        return Left(message);
      }

  }

  @override
  Future<Either> sendPasswordResetEmail(String email)async {
    try{
     await FirebaseAuth.instance.sendPasswordResetEmail(email: email);

     return Right("Password reset email is sent");


    }catch(e){
      return Left("${e.toString()} is occurred");
    }

  }

  @override
  Future<bool> isLoggedIn()async {
   if(FirebaseAuth.instance.currentUser != null ){
     return true;
   }
   else{
     return false;
   }
  }

  @override
  Future<Either> getUser() async{
    try{
   var currentUser= FirebaseAuth.instance.currentUser;

   var userData= await FirebaseFirestore.instance.
   collection('Users').doc(currentUser?.uid).get().then((value)=>value.data());

   return Right(userData);

    }
        catch(e){
      return Left('Some error occured');
        }



  }

}