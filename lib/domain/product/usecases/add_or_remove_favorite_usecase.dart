import 'package:dartz/dartz.dart';
import 'package:ecommers/core/usecase/usecase.dart';
import 'package:ecommers/domain/product/entities/product.dart';
import 'package:ecommers/domain/product/repository/product.dart';
import 'package:ecommers/service_locator.dart';

class AddOrRemoveFavoriteProductUseCase implements UseCase<Either,ProductEntity> {

  @override
  Future<Either> call({ProductEntity? params}) async {
    return await sl<ProductRepository>().addOrRemoveFavoriteProduct(params!);
  }

}