import 'package:dartz/dartz.dart';
import 'package:ecommers/data/categories/models/category.dart';
import 'package:ecommers/data/categories/source/categegory_firebase_service.dart';
import 'package:ecommers/domain/category/repository/category.dart';
import 'package:ecommers/service_locator.dart';

class CategoryRepositoryImpl extends CategoryRepository{
  @override
  Future<Either> getCategories() async{

 var categories=await sl<CategoryFirebaseService>().getCategories();
 return categories.fold((error){return Left(error);}, (data){return Right(List.from(data).map((e)=>CategoryModel.fromJson(e).toEntity()).toList());});
  }

}