import 'package:ecommers/common/bloc/product/product_cubit.dart';
import 'package:ecommers/common/bloc/product/product_state.dart';
import 'package:ecommers/common/widget/app_bar/basic_app_bar.dart';
import 'package:ecommers/common/widget/product/product_card.dart';
import 'package:ecommers/domain/product/entities/product.dart';
import 'package:ecommers/domain/product/usecases/get_favorite_usecase.dart';
import 'package:ecommers/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyFavoritesPage extends StatelessWidget {
  const MyFavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BasicAppBar(
        title: Text(
            'My Favorites'
        ),
      ),
      body: BlocProvider(
          create: (context) => ProductDisplayCubit(useCase: sl<GetFavoriteUseCase>())..displayProduct(),
          child: BlocBuilder<ProductDisplayCubit,ProductDisplayState>(
            builder: (context, state) {
              if (state is ProductLoading){
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is ProductLoaded) {
                return _products(state.product);
              }

              if (state is ProductLoadFailure){
                return const Center(
                  child: Text(
                      'Please try again'
                  ),
                );
              }

              return Container();
            },
          )
      ),
    );
  }

  Widget _products(List<ProductEntity> products) {
    return Expanded(
      child: GridView.builder(
        itemCount: products.length,
        padding: const EdgeInsets.all(16),
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