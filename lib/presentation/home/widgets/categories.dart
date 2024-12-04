import 'package:ecommers/common/bloc/categories/categories_display_cubit.dart';
import 'package:ecommers/common/bloc/categories/categories_display_state.dart';
import 'package:ecommers/common/helper/image/image_display_helper.dart';
import 'package:ecommers/common/helper/navigator/app_navigator.dart';
import 'package:ecommers/core/constants/app_url.dart';
import 'package:ecommers/domain/category/entities/category.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../all_categories/pages/all_category_page.dart';

class Categories extends StatelessWidget {
  const Categories({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CategoriesDisplayCubit()..displayCategories(),
      child: BlocBuilder<CategoriesDisplayCubit, CategoriesDisplayState>(
        builder: (context, state) {
          if (state is CategoriesLoading) {
            return Container(
              alignment: Alignment.center,
              child: const CircularProgressIndicator(),
            );
          }
          if (state is CategoriesLoaded) {
            return Column(
              children: [
                _seeAll(context),
                SizedBox(
                  height: 20,
                ),
                _category(state.categories),
              ],
            );
          }
          if (state is CategoriesFailure) {
            return Center(
              child: Text('please try again'),
            );
          }
          print("State is ${state.toString()}");
          return Container();
        },
      ),
    );
  }

  Widget _seeAll(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Categories',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        GestureDetector(
          onTap: ()=>AppNavigator.push(context,AllCategoryPage()),
          child: Text(
            "See All",
            style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
          ),
        ),
      ],
    );
  }

  Widget _category(List<CategoryEntity> categories) {
    return SizedBox(
      height: 100,
      child: ListView.separated(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return Column(
              children: [
                Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    image: DecorationImage(
                      image: NetworkImage(
                        ImageDisplayHelper.generateCategoriesImageURL(
                          categories[index].image,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(categories[index].title,  style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 14
                ),)
              ],
            );
          },
          separatorBuilder: (context, index) => SizedBox(
                width: 10,
              ),
          itemCount: categories.length),
    );
  }
}
