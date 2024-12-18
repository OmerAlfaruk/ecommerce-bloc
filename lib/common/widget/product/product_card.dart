import 'package:ecommers/common/helper/image/image_display_helper.dart';
import 'package:ecommers/common/helper/navigator/app_navigator.dart';
import 'package:ecommers/core/config/theme/app_colors.dart';
import 'package:ecommers/presentation/product_detail/page/product_detail_page.dart';
import 'package:flutter/material.dart';

import '../../../domain/product/entities/product.dart';

class ProductCard extends StatelessWidget {
  final ProductEntity productEntity;
  const ProductCard({
    super.key,
    required this.productEntity,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => AppNavigator.push(
          context, ProductDetailPage(productEntity: productEntity)),
      child: Container(
        width: 180, // Set width for the rectangle
        decoration: BoxDecoration(
          color: AppColors.secondBackground, // Add color
          borderRadius: BorderRadius.all(
              Radius.circular(10)), // Optional: Rounded corners
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 4,
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    image: DecorationImage(
                        fit: BoxFit.fill,
                        image: NetworkImage(
                            ImageDisplayHelper.generateProductsImageURL(
                                productEntity.images[0]))),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8),
                        topRight: Radius.circular(8))),
              ),
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      productEntity.title,
                      style: const TextStyle(
                          fontSize: 12,
                          overflow: TextOverflow.ellipsis,
                          fontWeight: FontWeight.w300),
                    ),
                    Row(
                      children: [
                        Text(
                          productEntity.discountedPrice == 0
                              ? "${productEntity.price}\$"
                              : "${productEntity.discountedPrice}\$",
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          productEntity.discountedPrice == 0
                              ? ''
                              : "${productEntity.price}\$",
                          style: const TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                              fontWeight: FontWeight.w300,
                              decoration: TextDecoration.lineThrough),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
