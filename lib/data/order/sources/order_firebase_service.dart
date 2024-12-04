import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:ecommers/data/order/models/add_to_card.dart';
import 'package:ecommers/data/order/models/order_regestration_req.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class OrderFirebaseService {
  Future<Either> addToCart(AddToCartReq addToCartReq);
  Future<Either> getCartProducts();
  Future<Either> getOrders();
  Future<Either> removeCartProducts(String id);
  Future<Either> orderRegistration(OrderRegistrationReq orderRegistrationReq);
}

class OrderFirebaseServiceImpl extends OrderFirebaseService {
  @override
  Future<Either> addToCart(AddToCartReq addToCartReq) async{
    try {
      var user = FirebaseAuth.instance.currentUser;

     await FirebaseFirestore.instance
          .collection('Users')
          .doc(user!.uid)
          .collection('Cart')
          .add(addToCartReq.toMap());

      return const Right('Order Recorded');
    }
    catch (e) {
      return const Left('Please try again');

    }
  }

  @override
  Future<Either<String, List<Map<String, dynamic>>>> getCartProducts() async {
    try {
      var user = FirebaseAuth.instance.currentUser;

      if (user == null) {
        return const Left('User not authenticated.');
      }

      var returnedData = await FirebaseFirestore.instance
          .collection('Users')
          .doc(user.uid)
          .collection('Cart')
          .get();

      // Ensure proper handling of Firestore documents
      List<Map<String, dynamic>> products = returnedData.docs.map((item) {
        var data = Map<String, dynamic>.from(item.data()); // Make a mutable copy
        data['id'] = item.id; // Add the document ID
        return data;
      }).toList();

      return Right(products);
    } catch (e) {
      return Left('Failed to fetch cart products: $e');
    }
  }

  @override
  Future<Either> removeCartProducts(String id) async{
    try {
      var user = FirebaseAuth.instance.currentUser;
      var returnedData = await FirebaseFirestore.instance.collection(
          'Users'
      ).doc(user!.uid).collection('Cart').doc(id).delete();

      return Right('Order is canceled successfully');
    }catch(e){
      return Left('Some error occured');
    }

    }

  @override
  Future<Either> orderRegistration(OrderRegistrationReq orderRegistrationReq) async {
    try {
      var user = FirebaseAuth.instance.currentUser;
      await FirebaseFirestore.instance.collection(
          'Users'
      ).doc(user!.uid).collection('Orders').add(
          orderRegistrationReq.toMap()
      );

      for (var item in orderRegistrationReq.products) {
        await FirebaseFirestore.instance.collection(
            'Users'
        ).doc(user.uid).collection('Cart').doc(item.id).delete();
      }

      return const Right('Order registered successfully');
    } catch (e) {
      print(e.toString());
      return  Left(

          e.toString()
      );

    }

  }

  @override

    Future < Either > getOrders() async {
      try {
        var user = FirebaseAuth.instance.currentUser;
        var returnedData = await FirebaseFirestore.instance.collection(
            "Users"
        ).doc(user!.uid).collection('Orders').get();
        return Right(returnedData.docs.map((e) => e.data()).toList());
      } catch (e) {
        print(e.toString());
        return const Left(
            'Please try again'
        );
      }
    }
  }

