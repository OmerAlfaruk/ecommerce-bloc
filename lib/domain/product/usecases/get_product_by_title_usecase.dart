import 'package:dartz/dartz.dart';
import 'package:ecommers/core/usecase/usecase.dart';
import 'package:ecommers/domain/product/repository/product.dart';
import 'package:ecommers/service_locator.dart';

class GetProductByTitleUseCase implements UseCase<Either,String>{
  @override
  Future<Either> call({String? params}) {
    return sl<ProductRepository>().getProductByTitle(params!);
  }

}