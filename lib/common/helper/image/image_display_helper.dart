import 'package:ecommers/core/constants/app_url.dart';

class ImageDisplayHelper{
 static String generateCategoriesImageURL(String title){
    return AppUrl.categoryImage+title+AppUrl.alt;
  }
  static String generateProductsImageURL(String title){
    return AppUrl.productImage+title+AppUrl.alt;
  }
}