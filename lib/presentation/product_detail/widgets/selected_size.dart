import 'package:ecommers/common/helper/bottomsheet/app_bottomsheet.dart';
import 'package:ecommers/core/config/theme/app_colors.dart';
import 'package:ecommers/domain/product/entities/product.dart';
import 'package:ecommers/presentation/product_detail/bloc/product_size_seletion_cubit.dart';
import 'package:ecommers/presentation/product_detail/widgets/product_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SelectedSize extends StatelessWidget {
  final ProductEntity productEntity;

  const SelectedSize({required this.productEntity, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
          height: 60,
          decoration: BoxDecoration(
              color: AppColors.secondBackground,
              borderRadius: BorderRadius.circular(16)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Padding(
                padding: EdgeInsets.all(16),
                child: Text('Size'),
              ),
              Row(
                children: [
                  BlocBuilder<ProductSizeSelectionCubit,int>(
                    builder: (context, state) {
                      return Text(productEntity.sizes[state]);
                    },
                  ),
                  IconButton(
                      onPressed: () {
                        AppBottomSheet.display(
                            context,
                            BlocProvider.value(

                              value: BlocProvider.of<
                                  ProductSizeSelectionCubit>(context),
                              child: ProductSize(
                                productEntity: productEntity,
                              ),
                            ));
                      },
                      icon: const Icon(Icons.keyboard_arrow_down_outlined))
                ],
              )
            ],
          )),
    );
  }
}
