import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

abstract class CategoryFirebaseService{
  Future<Either> getCategories();

}
class CategoryFirebaseServiceImpl implements CategoryFirebaseService{
  @override
  Future<Either> getCategories() async {
    try {
      print("Fetching categories from Firestore...");
      final querySnapshot = await FirebaseFirestore.instance
          .collection('Catagories')
          .get();

      final categories = querySnapshot.docs.map((e) => e.data()).toList();
      print("Fetched categories: $categories");

      return Right(categories);
    } catch (e, stackTrace) {
      print("Error fetching categories: $e\n$stackTrace");
      return Left("Failed to fetch categories. Please try again.");
    }
  }

}