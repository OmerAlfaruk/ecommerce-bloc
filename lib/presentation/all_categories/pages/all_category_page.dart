import 'package:ecommers/common/helper/image/image_display_helper.dart';
import 'package:ecommers/common/helper/navigator/app_navigator.dart';
import 'package:ecommers/common/widget/app_bar/basic_app_bar.dart';
import 'package:ecommers/core/config/theme/app_colors.dart';
import 'package:ecommers/presentation/product_category/product_category.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/bloc/categories/categories_display_cubit.dart';
import '../../../common/bloc/categories/categories_display_state.dart';
import '../../../domain/category/entities/category.dart';

class AllCategoryPage extends StatelessWidget {
  const AllCategoryPage({super.key});


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: BasicAppBar(),
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: BlocProvider(
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      _shopByCategory(),
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
          ),
        ),
      ),
    );
  }

  Widget _shopByCategory() {
    return Text(
      'Shop By Categories',
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
    );
  }

  Widget _category(List<CategoryEntity> categories) {
    return SizedBox(

      child: ListView.separated(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: ()=>AppNavigator.push(context,ProductCategoryPage(categoryEntity: categories[index],)),
              child: Container(
              
                decoration: BoxDecoration(
                    color: AppColors.secondBackground,
                  borderRadius: BorderRadius.circular(20)
                ),
                child: Row(
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
                      width: 30,
                    ),
                    Text(categories[index].title,  style: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 14
                    ),)
                  ],
                ),
              ),
            );
          },
          separatorBuilder: (context, index) => const SizedBox(
            height: 20,
          ),
          itemCount: categories.length),
    );
  }
}
