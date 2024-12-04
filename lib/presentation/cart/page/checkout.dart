import 'package:ecommers/common/bloc/button/button_cubit.dart';
import 'package:ecommers/common/bloc/button/button_state.dart';
import 'package:ecommers/common/helper/cart/cart.dart';
import 'package:ecommers/common/helper/navigator/app_navigator.dart';
import 'package:ecommers/common/widget/app_bar/basic_app_bar.dart';
import 'package:ecommers/common/widget/bottons/basic_reactive_button.dart';
import 'package:ecommers/core/config/theme/app_colors.dart';
import 'package:ecommers/data/order/models/order_regestration_req.dart';
import 'package:ecommers/domain/order/entities/product_ordered.dart';
import 'package:ecommers/domain/order/usecase/order_registration_usecase.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'order_placed.dart';

class CheckoutPage extends StatelessWidget {
  final List<ProductOrderedEntity> products;
  CheckoutPage({super.key, required this.products});
  final TextEditingController _addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: BasicAppBar(
        title: Text('Checkout'),
      ),
      body: BlocProvider(
        create: (context) => ButtonCubit(),
        child: BlocListener<ButtonCubit, ButtonState>(
          listener: (context, state) {
            if (state is ButtonSuccess) {
              AppNavigator.pushAndRemove(context, const OrderPlacedPage());
            }
            if (state is ButtonFailure) {
              var snackbar = SnackBar(
                content: Text(state.errorMessage),
                behavior: SnackBarBehavior.floating,
              );
              ScaffoldMessenger.of(context).showSnackBar(snackbar);
            }
          },
          child: Padding(
            padding: EdgeInsets.all(16),
            child: BlocBuilder<ButtonCubit, ButtonState>(
                builder: (context, state) {
                  print('ProductOrderedModel instance: $products');;

                  return Stack(
                children: [
                  _addressField(),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: BasicReactiveButton(
                      onPressed: () {
                        context.read<ButtonCubit>().execute(
                            useCase: OrderRegistrationUseCase(),
                            params: OrderRegistrationReq(
                                products: products,
                                createdDate: DateTime.now().toString(),
                                itemCount: products.length,
                                totalPrice:
                                    CartHelper.calculateCartSubtotal(products),
                                shippingAddress: _addressController.text));
                      },
                      content: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('\$460'),
                          Text("Place Order"),
                        ],
                      ),
                    ),
                  )
                ],
              );
            }),
          ),
        ),
      ),
    ));
  }

  Widget _addressField() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            color: AppColors.secondBackground,
            borderRadius: BorderRadius.circular(10)),
        height: 100,
        child: Center(
          child: TextField(
            controller: _addressController,
            decoration: InputDecoration(
              hintText: 'Enter Shipping Address',
            ),
          ),
        ),
      ),
    );
  }
}
