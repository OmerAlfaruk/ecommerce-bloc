import 'package:ecommers/common/bloc/product/product_cubit.dart';
import 'package:ecommers/common/bloc/product/product_state.dart';
import 'package:ecommers/common/widget/product/product_card.dart';
import 'package:ecommers/domain/product/usecases/get_new_in_uses_case.dart';
import 'package:ecommers/domain/product/usecases/get_top_selling_usecase.dart';
import 'package:ecommers/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../../../domain/product/entities/product.dart';

class NewIn extends StatelessWidget {
  const NewIn({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
      ProductDisplayCubit(useCase: sl<GetNewInUsesCase>())
        ..displayProduct(),
      child: BlocBuilder<ProductDisplayCubit, ProductDisplayState>(
        builder: (context, state) {
          if(state is ProductLoading){
            return Container(alignment: Alignment.center,child: const CircularProgressIndicator(),);
          }
          if(state is ProductLoaded){

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _topSelling(),
                const SizedBox(height: 20,),
                _product(state.product)


              ],

            );
          }
          if (state is ProductLoadFailure){
            return const Center(child: Text('Please try again'),);
          }
          return Container();
        },
      ),
    );
  }

  Widget _topSelling() {
    return const Text(
      'New In',
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
    );
  }

  Widget _product(List<ProductEntity> productEntity) {
    return SizedBox(
      height: 300,
      child: ListView.separated(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return ProductCard(productEntity: productEntity[index],);
          },
          separatorBuilder: (context, index) =>
          const SizedBox(
            width: 10,
          ),
          itemCount: productEntity.length),
    );
  }

}


