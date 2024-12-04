import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:ecommers/data/product/model/product.dart';
import 'package:ecommers/domain/product/entities/product.dart';
import 'package:ecommers/service_locator.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class ProductFirebaseService {
  Future<Either> getTopSelling();
  Future<Either> getNewIn();
  Future<Either> getProductByCategoryId(String categoryId);
  Future<Either> getProductByTitle(String title);
  Future<Either> addOrRemoveFavoriteProduct(ProductEntity product);
  Future<bool> isFavorite(String id);
  Future<Either> getFavoriteProducts();
}

class ProductFirebaseServiceImpl extends ProductFirebaseService {
  @override
  Future<Either> getTopSelling() async {
    try {
      var returnedData = await FirebaseFirestore.instance
          .collection('Products')
          .where('salesNumber', isGreaterThanOrEqualTo: 0)
          .get();

      // Log the retrieved data for inspection
      print("Returned data: ${returnedData.docs.map((e) => e.data())}");

      return Right(returnedData.docs.map((e) => e.data()).toList());
    } catch (e) {
      print("Error in geTopSelling: $e"); // Log the exact error
      return Left(e.toString());
    }
  }

  @override
  Future<Either> getNewIn() async {
    try {
      var returnedData = await FirebaseFirestore.instance
          .collection('Products')
          .where('createdAt',
              isGreaterThanOrEqualTo: Timestamp.fromDate(DateTime(2024, 7, 25)))
          .get();

      // Log the retrieved data for inspection
      print("Returned data: ${returnedData.docs.map((e) => e.data())}");

      return Right(returnedData.docs.map((e) => e.data()).toList());
    } catch (e) {
      print("Error in geTopSelling: $e"); // Log the exact error
      return Left(e.toString());
    }
  }

  @override
  Future<Either> getProductByCategoryId(String categoryId) async {
    try {
      var returnedData = await FirebaseFirestore.instance
          .collection('Products')
          .where('categoryId', isEqualTo: categoryId)
          .get();

      // Log the retrieved data for inspection
      print("Returned data: ${returnedData.docs.map((e) => e.data())}");

      return Right(returnedData.docs.map((e) => e.data()).toList());
    } catch (e) {
      print("Error in geTopSelling: $e"); // Log the exact error
      return Left(e.toString());
    }
  }

  @override
  Future<Either> getProductByTitle(String title) async {
    try {
      var returnedData = await FirebaseFirestore.instance
          .collection('Products')
          .where('title', isGreaterThanOrEqualTo: title)
          .get();

      // Log the retrieved data for inspection
      print("Returned data: ${returnedData.docs.map((e) => e.data())}");

      return Right(returnedData.docs.map((e) => e.data()).toList());
    } catch (e) {
      print("Error in geTopSelling: $e"); // Log the exact error
      return Left(e.toString());
    }
  }

  @override
  Future < Either > addOrRemoveFavoriteProduct(ProductEntity product) async {
    try {
      var user = FirebaseAuth.instance.currentUser;
      var products = await FirebaseFirestore.instance.collection(
          "Users"
      ).doc(user!.uid).collection('Favorites').where(
          'productId', isEqualTo: product.productId
      ).get();

      if (products.docs.isNotEmpty) {
        await products.docs.first.reference.delete();
        return const Right(false);
      } else {
        await FirebaseFirestore.instance.collection(
            "Users"
        ).doc(user.uid).collection('Favorites').add(
            product.fromEntity().toMap()
        );
        return const Right(true);
      }

    } catch (e) {
      print(e);
      return const Left(

          'Please try again'
      );
    }
  }

  @override
  Future < bool > isFavorite(String id) async {
    try {
      var user = FirebaseAuth.instance.currentUser;
      var products = await FirebaseFirestore.instance.collection(
          "Users"
      ).doc(user!.uid).collection('Favorites').where(
          'productId', isEqualTo: id
      ).get();

      if (products.docs.isNotEmpty) {
        return true;
      } else {
        return false;
      }

    } catch (e) {
      return false;
    }
  }


    @override
    Future < Either > getFavoriteProducts() async {
      try {
        var user = FirebaseAuth.instance.currentUser;
        var returnedData = await FirebaseFirestore.instance.collection(
            "Users"
        ).doc(user!.uid).collection('Favorites').get();
        return Right(returnedData.docs.map((e) => e.data()).toList());
      } catch (e) {
        print(e.toString());
        return const Left(
            'Please try again'
        );
      }
    }

  }
