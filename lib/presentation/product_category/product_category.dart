import 'package:ecommers/common/bloc/product/product_cubit.dart';
import 'package:ecommers/common/bloc/product/product_state.dart';
import 'package:ecommers/common/widget/app_bar/basic_app_bar.dart';
import 'package:ecommers/common/widget/product/product_card.dart';
import 'package:ecommers/domain/category/entities/category.dart';
import 'package:ecommers/domain/product/entities/product.dart';
import 'package:ecommers/domain/product/usecases/get_product_by_category_Id_usecase.dart';
import 'package:ecommers/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';



class ProductCategoryPage extends StatelessWidget {
final CategoryEntity categoryEntity;

  const ProductCategoryPage({super.key, required this.categoryEntity});
@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: const BasicAppBar(),
    body: BlocProvider(
        create: (context) => ProductDisplayCubit(useCase: sl<GetProductByCategoryIdUseCase>())..displayProduct(params: categoryEntity.categoryId),
        child: BlocBuilder<ProductDisplayCubit,ProductDisplayState>(
          builder: (context, state) {
            if (state is ProductLoading){
              return const Center(child: CircularProgressIndicator());
            }
            if (state is ProductLoaded) {
              return Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _categoryInfo(state.product),
                    const SizedBox(height: 10,),
                    _products(state.product)
                  ],
                ),
              );
            }
            return Container();
          },
        )
    ) ,
  );
}

Widget _categoryInfo(List<ProductEntity> products) {
  return Text(
    '${categoryEntity.title} (${products.length})',
    style: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 16
    ),
  );
}

Widget _products(List<ProductEntity> products) {
  return Expanded(
    child: GridView.builder(
      itemCount: products.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 0.6
      ),
      itemBuilder: (BuildContext context, int index) {
        return ProductCard(productEntity: products[index]);
      },
    ),
  );
}
}
