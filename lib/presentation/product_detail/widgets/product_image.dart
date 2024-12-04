import 'package:ecommers/common/helper/image/image_display_helper.dart';
import 'package:ecommers/domain/product/entities/product.dart';
import 'package:flutter/material.dart';

class ProductImage extends StatelessWidget {
  final ProductEntity productEntity;
  const ProductImage({super.key, required this.productEntity});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: ListView.separated(
          padding: EdgeInsets.symmetric(horizontal: 16),
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return Container(
              width: 200,
              decoration: BoxDecoration(
                color: Colors.white,
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: NetworkImage(
                    ImageDisplayHelper.generateProductsImageURL(
                      productEntity.images[index],

                    ),
                  ),
                ),
              ),
            );
          },
          separatorBuilder: (context, index) => SizedBox(
                width: 10,
              ),
          itemCount: productEntity.images.length),
    );
  }
}
