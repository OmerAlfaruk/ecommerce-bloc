import 'package:dartz/dartz.dart';
import 'package:ecommers/data/product/model/product.dart';
import 'package:ecommers/data/product/source/product_firebase_servive.dart';
import 'package:ecommers/domain/product/entities/product.dart';
import 'package:ecommers/domain/product/repository/product.dart';
import 'package:ecommers/service_locator.dart';

class ProductRepositoryImpl extends ProductRepository{
  @override
  Future<Either> getTopSelling() async{
var products=await sl<ProductFirebaseService>().getTopSelling();

return products.fold((error){return Left(error);},
        (data){return Right(List.from(data).map((e)=>ProductModel.fromMap(e).toEntity()).toList());});
  }

  @override
  Future<Either> getNewIn()async{
    var products=await sl<ProductFirebaseService>().getNewIn();

    return products.fold((error){return Left(error);},
            (data){return Right(List.from(data).map((e)=>ProductModel.fromMap(e).toEntity()).toList());});
  }

  @override
  Future<Either> getProductByCategoryId(String categoryId) async{
    var products=await sl<ProductFirebaseService>().getProductByCategoryId(categoryId);
    return products.fold((error){return Left(error);},
            (data){return Right(List.from(data).map((e)=>ProductModel.fromMap(e).toEntity()).toList());});

  }

  @override
  Future<Either> getProductByTitle(String title) async{
    var products=await sl<ProductFirebaseService>().getProductByTitle(title);
    return products.fold((error){return Left(error);},
            (data){return Right(List.from(data).map((e)=>ProductModel.fromMap(e).toEntity()).toList());});
  }

  @override
  Future<Either> addOrRemoveFavoriteProduct(ProductEntity product) async {
    var returnedData = await sl<ProductFirebaseService>().addOrRemoveFavoriteProduct(product);
    return returnedData.fold(
            (error){
          return Left(error);
        },
            (data){
          return Right(
              data
          );
        }
    );
  }

  @override
  Future<bool> isFavorite(String id) {
   return sl<ProductFirebaseService>().isFavorite(id);
  }

  @override
  Future<Either> getFavoriteProducts() async{
    var returnedData = await sl<ProductFirebaseService>().getFavoriteProducts();
    return returnedData.fold(
            (error){
          return Left(error);
        },
            (data){
          return Right(
              List.from(data).map((e) => ProductModel.fromMap(e).toEntity()).toList()
          );
        }
    );
  }


  }

