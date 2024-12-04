import 'package:dartz/dartz.dart';
import 'package:ecommers/core/usecase/usecase.dart';
import 'package:ecommers/domain/category/repository/category.dart';
import 'package:ecommers/service_locator.dart';

class GetCategoryUseCase extends UseCase<Either,dynamic>{
  @override
  Future<Either> call({params}) {
   return sl<CategoryRepository>().getCategories();
  }

}