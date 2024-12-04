import 'package:ecommers/common/bloc/product/product_cubit.dart';
import 'package:ecommers/core/config/assets/app_vectors.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';


class SearchField extends StatelessWidget {
  SearchField({super.key});

  final TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: 8
      ),
      child: TextField(
        controller: textEditingController,
        onChanged: (value){
          if (value.isEmpty) {
            context.read<ProductDisplayCubit>().displayInitial();
          } else {
            context.read<ProductDisplayCubit>().displayProduct(params: value);
          }
        },
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(12),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(50)
            ),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(50)
            ),
            prefixIcon:  SvgPicture.asset(
              AppVectors.search,
              fit: BoxFit.none,
            ),
            hintText: 'search'
        ),
      ),
    );
  }
}