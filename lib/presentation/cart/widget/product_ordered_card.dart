import 'package:ecommers/common/bloc/button/button_cubit.dart';
import 'package:ecommers/common/bloc/button/button_state.dart';
import 'package:ecommers/common/bloc/product/product_cubit.dart';
import 'package:ecommers/common/helper/image/image_display_helper.dart';
import 'package:ecommers/core/config/theme/app_colors.dart';
import 'package:ecommers/domain/order/entities/product_ordered.dart';
import 'package:ecommers/domain/order/usecase/remove_cart_order_usecase.dart';
import 'package:ecommers/presentation/cart/bloc/cart_products_display_cubit.dart';
import 'package:ecommers/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductOrderedCard extends StatelessWidget {
  final ProductOrderedEntity product;
  const ProductOrderedCard({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: AppColors.secondBackground,
          borderRadius: BorderRadius.circular(10)),
      padding: const EdgeInsets.all(10),
      child: SizedBox(
        height: 100,
        child: Row(
          children: [
            Container(
              width: 100,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(
                          ImageDisplayHelper.generateProductsImageURL(
                              product.productImage)),
                      fit: BoxFit.fill)),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Stack(
                  children: [
                    Align(
                        alignment: Alignment.topLeft,
                        child: Text(product.productTitle)),
                    Align(
                      alignment: Alignment.topRight,
                      child: Text("\$${product.totalPrice}"),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: GestureDetector(
                            onTap: (){
                              context.read<CartProductsDisplayCubit>().removeCartProduct(product.id);
                            },
                            child: Container(
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                  color: Colors.red.shade300,
                                  shape: BoxShape.circle),
                              child: const Icon(Icons.remove),
                            ),

                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Row(
                        children: [
                          const Text(
                            'Size',
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(product.productSize,
                              style: const TextStyle(fontSize: 12)),
                          const SizedBox(
                            width: 5,
                          ),
                          const Text('Color',
                              style:
                                  TextStyle(fontSize: 12, color: Colors.grey)),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(product.productColor,
                              style: const TextStyle(fontSize: 12)),
                          const SizedBox(
                            width: 5,
                          ),
                          const Text('Quantity',
                              style:
                                  TextStyle(fontSize: 12, color: Colors.grey)),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(product.productQuantity.toString(),
                              style: const TextStyle(fontSize: 12)),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
