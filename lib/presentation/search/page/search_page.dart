import 'package:ecommers/common/bloc/product/product_cubit.dart';
import 'package:ecommers/common/bloc/product/product_state.dart';
import 'package:ecommers/common/widget/app_bar/basic_app_bar.dart';
import 'package:ecommers/presentation/search//widget/search.dart';
import 'package:ecommers/core/config/assets/app_vectors.dart';
import 'package:ecommers/domain/product/usecases/get_product_by_title_usecase.dart';
import 'package:ecommers/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../common/widget/product/product_card.dart';
import '../../../domain/product/entities/product.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductDisplayCubit(useCase: sl<GetProductByTitleUseCase>(),),
  child: Scaffold(
      appBar:BasicAppBar(
        title:  SearchField(),
      ),
      body: BlocBuilder<ProductDisplayCubit,ProductDisplayState>(
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

                  const SizedBox(height: 10,),
                  state.product.isEmpty?_notFound():_products(state.product)
                ],
              ),
            );
          }
          return Container();
        },
      ) ,
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

  Widget _notFound(){
    return Column(
      children: [
        SvgPicture.asset(AppVectors.notFound),
        const Padding(padding: EdgeInsets.all(16),child: Text("Sorry,we couldn't find any matching result for your search",
        textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20,
          fontWeight: FontWeight.w500),
        ),),
      ],

    );
  }
}
