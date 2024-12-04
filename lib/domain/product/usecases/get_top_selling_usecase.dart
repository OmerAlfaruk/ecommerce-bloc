import 'package:dartz/dartz.dart';
import 'package:ecommers/core/usecase/usecase.dart';
import 'package:ecommers/domain/product/repository/product.dart';

import '../../../service_locator.dart';

class GetTopSellingUseCase extends UseCase<Either,dynamic>{
  @override
  Future<Either> call({params}) {
return sl<ProductRepository>().getTopSelling();
  }

}