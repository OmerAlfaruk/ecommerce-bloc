import 'package:ecommers/common/bloc/button/button_cubit.dart';
import 'package:ecommers/common/widget/app_bar/basic_app_bar.dart';
import 'package:ecommers/domain/product/entities/product.dart';
import 'package:ecommers/presentation/product_detail/bloc/favorite_icon_cubit.dart';
import 'package:ecommers/presentation/product_detail/bloc/product_color_selection_cubit.dart';
import 'package:ecommers/presentation/product_detail/bloc/product_quantity_cubit.dart';
import 'package:ecommers/presentation/product_detail/widgets/add_to_cart.dart';
import 'package:ecommers/presentation/product_detail/widgets/add_to_favorite_button.dart';
import 'package:ecommers/presentation/product_detail/widgets/product_image.dart';
import 'package:ecommers/presentation/product_detail/widgets/product_price.dart';
import 'package:ecommers/presentation/product_detail/widgets/product_quantity.dart';
import 'package:ecommers/presentation/product_detail/widgets/product_title.dart';
import 'package:ecommers/presentation/product_detail/widgets/selected_color.dart';
import 'package:ecommers/presentation/product_detail/widgets/selected_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/product_size_seletion_cubit.dart';

class ProductDetailPage extends StatelessWidget {
  final ProductEntity productEntity;

  const ProductDetailPage({super.key, required this.productEntity});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ProductQuantityCubit(),
        ),
        BlocProvider(
          create: (context) => ProductColorSelectionCubit(),
        ),
        BlocProvider(
          create: (context) => ProductSizeSelectionCubit(),
        ),
        BlocProvider(
          create: (context) => ButtonCubit(),
        ),
        BlocProvider(
          create: (context) => FavoriteIconCubit()..isFavorite(productEntity.productId),  // Initialize with productId
        ),
      ],
      child: Scaffold(
        appBar: BasicAppBar(
          action: FavoriteButton(productEntity: productEntity),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ProductImage(
                productEntity: productEntity,
              ),
              const SizedBox(
                height: 15,
              ),
              ProductTitle(
                productEntity: productEntity,
              ),
              const SizedBox(
                height: 15,
              ),
              ProductPrice(
                productEntity: productEntity,
              ),
              const SizedBox(
                height: 15,
              ),
              SelectedSize(productEntity: productEntity),
              const SizedBox(
                height: 15,
              ),
              SelectedColor(
                productEntity: productEntity,
              ),
              const SizedBox(
                height: 15,
              ),
              ProductQuantity(
                productEntity: productEntity,
              ),
              const SizedBox(
                height: 15,
              ),
              AddToCart(
                productEntity: productEntity,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
