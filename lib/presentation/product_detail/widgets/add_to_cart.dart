import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommers/common/bloc/button/button_cubit.dart';
import 'package:ecommers/common/bloc/button/button_state.dart';
import 'package:ecommers/common/helper/navigator/app_navigator.dart';
import 'package:ecommers/common/helper/product/product_price.dart';

import 'package:ecommers/common/widget/bottons/basic_reactive_button.dart';

import 'package:ecommers/data/order/models/add_to_card.dart';
import 'package:ecommers/domain/order/usecase/add_to_cart_usecase.dart';
import 'package:ecommers/domain/product/entities/product.dart';
import 'package:ecommers/presentation/cart/page/cart.dart';
import 'package:ecommers/presentation/product_detail/bloc/product_quantity_cubit.dart';
import 'package:ecommers/presentation/product_detail/bloc/product_size_seletion_cubit.dart';
import 'package:ecommers/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/product_color_selection_cubit.dart';

class AddToCart extends StatelessWidget {
  final ProductEntity productEntity;
  const AddToCart({required this.productEntity, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: BlocListener<ButtonCubit, ButtonState>(
        listener: (context, state) {
          if(state is ButtonSuccess){
            AppNavigator.push(context, CartPage());
          } if(state is ButtonFailure){
            var snackBar=SnackBar(content: Text(state.errorMessage));
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
        },
        child: BasicReactiveButton(
            onPressed: () {
              context.read<ButtonCubit>().execute(
                useCase: sl<AddToCartUseCase>(),params:  AddToCartReq(
                  productId: productEntity.productId,
                  productTitle: productEntity.title,
                  productQuantity:
                  context.read<ProductQuantityCubit>().state,
                  productColor: productEntity
                      .colors[context
                      .read<ProductColorSelectionCubit>()
                      .selectedIndex]
                      .title,
                  productSize: productEntity.sizes[context
                      .read<ProductSizeSelectionCubit>()
                      .selectedIndex],
                  productPrice: productEntity.discountedPrice != 0
                      ? productEntity.discountedPrice.toDouble()
                      : productEntity.price.toDouble(),
                  totalPrice: ProductPriceHelper.provideCurrentPrice(
                      productEntity) *
                      context.read<ProductQuantityCubit>().state,
                  productImage: productEntity.images[0],
                createdDate:productEntity.createdAt.toString(),

                  ),);

            },
            content: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.all(16),
                  child: BlocBuilder<ProductQuantityCubit, int>(
                    builder: (context, state) {
                      var price = ProductPriceHelper.provideCurrentPrice(
                          productEntity) *
                          state;
                      return Text("\$$price");
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text("Add to Bag"),
                ),
              ],
            )),
      ),
    );
  }
}
