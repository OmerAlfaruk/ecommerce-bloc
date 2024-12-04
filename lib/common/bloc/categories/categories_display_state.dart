 import 'package:ecommers/domain/category/entities/category.dart';

class CategoriesDisplayState {}

 class CategoriesLoading extends CategoriesDisplayState {}
 class CategoriesLoaded extends CategoriesDisplayState {
  final List<CategoryEntity> categories;

  CategoriesLoaded({required this.categories});
 }
 class CategoriesFailure extends CategoriesDisplayState {}
