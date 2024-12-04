import 'package:dartz/dartz.dart';
import 'package:ecommers/domain/product/entities/product.dart';

abstract class ProductRepository{
  Future<Either> getTopSelling();
  Future<Either> getNewIn();
  Future<Either> getProductByCategoryId(String categoryId);

  Future<Either> getProductByTitle(String title);
  Future<Either> addOrRemoveFavoriteProduct(ProductEntity product);
  Future<bool> isFavorite(String id);
  Future<Either> getFavoriteProducts();
}