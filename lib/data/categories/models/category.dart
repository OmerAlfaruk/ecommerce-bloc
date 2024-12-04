import 'package:ecommers/domain/category/entities/category.dart';

class CategoryModel {
  final String title;
  final String categoryId;
  final String image;

  CategoryModel(
      {required this.title, required this.categoryId, required this.image});

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'categoryId': categoryId,
      'image': image,
    };
  }

  factory CategoryModel.fromJson(Map<String, dynamic> map) {
    return CategoryModel(
      title: map['title'] as String,
      categoryId: map['categoryId'] as String,
      image: map['image'] as String,
    );
  }
}
extension CategoryXModel on CategoryModel{
  CategoryEntity toEntity(){
    return CategoryEntity(title: title, categoryId: categoryId, image: image);
  }
}
