import 'package:ecommers/common/helper/navigator/app_navigator.dart';
import 'package:ecommers/core/config/assets/app_images.dart';
import 'package:ecommers/core/config/theme/app_colors.dart';
import 'package:ecommers/presentation/home/page/home_page.dart';
import 'package:flutter/material.dart';

import '../../../common/widget/bottons/basic_app_button.dart';

class OrderPlacedPage extends StatelessWidget {
  const OrderPlacedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Align(
            alignment: Alignment.center,
            child: Image.asset(
                AppImages.orderPlaced
            ) ,
          ),
          const SizedBox(height: 60,),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 300,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: const BoxDecoration(
                  color: AppColors.secondBackground,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)
                  )
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Order Placed Successfully',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20
                    ),
                  ),
                  const SizedBox(height: 30,),
                  BasicAppButton(
                      content: Text('Finish'),
                      onPressed: (){
                        AppNavigator.pushAndRemove(context, const HomePage());
                      }
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}