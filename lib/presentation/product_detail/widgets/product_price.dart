import 'package:ecommers/core/config/theme/app_colors.dart';
import 'package:ecommers/domain/product/entities/product.dart';
import 'package:flutter/material.dart';

class ProductPrice extends StatelessWidget {
  final ProductEntity productEntity;

  const ProductPrice({super.key, required this.productEntity});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Text("\$${productEntity.price.toString()}",style: TextStyle(
              fontWeight: FontWeight.w400,
              decoration: TextDecoration.lineThrough,
              fontSize: 14),),
          SizedBox(width: 30,),
          Text("\$${productEntity.discountedPrice.toString()}",style:  TextStyle(fontWeight: FontWeight.w400,
              fontSize: 14,
            color: AppColors.primary
          ),),
        ],
      ),
    );
  }
}
