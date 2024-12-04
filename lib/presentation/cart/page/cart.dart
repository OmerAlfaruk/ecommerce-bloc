import 'package:ecommers/common/bloc/button/button_cubit.dart';
import 'package:ecommers/common/helper/cart/cart.dart';
import 'package:ecommers/common/helper/navigator/app_navigator.dart';
import 'package:ecommers/common/widget/app_bar/basic_app_bar.dart';
import 'package:ecommers/common/widget/bottons/basic_app_button.dart';
import 'package:ecommers/common/widget/bottons/basic_reactive_button.dart';
import 'package:ecommers/core/config/assets/app_vectors.dart';
import 'package:ecommers/core/config/theme/app_colors.dart';
import 'package:ecommers/domain/order/entities/product_ordered.dart';
import 'package:ecommers/domain/product/entities/product.dart';
import 'package:ecommers/presentation/cart/bloc/cart_products_display_cubit.dart';
import 'package:ecommers/presentation/cart/bloc/cart_products_display_state.dart';
import 'package:ecommers/presentation/cart/widget/product_ordered_card.dart';
import 'package:ecommers/presentation/cart/page/checkout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: BasicAppBar(
        title: Text('Cart'),
      ),
      body: MultiBlocProvider(
  providers: [
    BlocProvider(
        create: (context) => CartProductsDisplayCubit()..displayCartProducts(),
),
    BlocProvider(
      create: (context) => ButtonCubit(),
    ),
  ],
  child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: BlocBuilder<CartProductsDisplayCubit, CartProductsDisplayState>(
            builder: (context, state) {
              if (state is CartProductsLoading) {
                return Container(
                  alignment: Alignment.center,
                  child: CircularProgressIndicator(),
                );
              }
              if (state is CartProductsLoaded) {
                return  state.products.isEmpty ? Center(child: _cartIsEmpty()) :Stack(
                  children: [
                    _cart(state.products),
                    Align(child: _checkout(context,state.products),alignment: Alignment.bottomCenter,)
                  ],
                ) ;
              }

              if (state is CartProductsFailure) {
                return Center(
                  child: Text(state.errorMessage),
                );
              }
              return Container();
            },
          ),
        ),
),
    );
  }

  Widget _cart(List<ProductOrderedEntity> products){
    return ListView.separated(
      scrollDirection: Axis.vertical,
        itemBuilder: (context,index){
        return  ProductOrderedCard(product: products[index],);
        }, separatorBuilder: (Context,index)=>SizedBox(height: 10,), itemCount: products.length);
  }
  
  Widget _checkout(BuildContext context,List<ProductOrderedEntity> products){
    return Container(
      color: AppColors.background,
      height: MediaQuery.of(context).size.height / 3.5,
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Subtotal",
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: 16
                ),),
              Text("\$${CartHelper.calculateCartSubtotal(products).toString()}",
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16
                ),),
            ],
          ),
          SizedBox(height: 10,) ,Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Shipping Coast",
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: 16
                ),),
              Text("\$8",
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16
                ),),
            ],
          ),
          SizedBox(height: 10,), Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Tax",
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: 16
                ),),
              Text("\$00",
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16
                ),),
            ],
          ),
          SizedBox(height: 10,), Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Total",
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: 16
                ),),
              Text("\$${(CartHelper.calculateCartSubtotal(products)+8).toString()}",
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16
                ),),
            ],
          ),
          SizedBox(height: 10,),
          BasicAppButton(onPressed: (){
            AppNavigator.push(context, CheckoutPage(products: products,));
          },content: Text('Checout'),)
        ],
      ),
    );
  }
  Widget _cartIsEmpty() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
            AppVectors.cartBag
        ),
        const SizedBox(height: 20,),
        const Text(
          "Cart is empty",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 20
          ),
        )
      ],
    );
  }
}

