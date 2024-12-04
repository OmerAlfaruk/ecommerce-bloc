import 'package:ecommers/core/usecase/usecase.dart';
import 'package:ecommers/domain/product/repository/product.dart';
import 'package:ecommers/service_locator.dart';

class IsFavoriteUseCase extends UseCase<bool,String>{
  @override
  Future<bool> call({String? params}) {
 return sl<ProductRepository>().isFavorite(params!);
  }

}