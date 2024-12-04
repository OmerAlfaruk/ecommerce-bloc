import 'package:ecommers/common/helper/navigator/app_navigator.dart';
import 'package:ecommers/core/config/theme/app_colors.dart';
import 'package:ecommers/presentation/setting/pages/my_orders.dart';
import 'package:flutter/material.dart';

class MyOrdersTitle extends StatelessWidget {
  const MyOrdersTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      height: 80,
      decoration: BoxDecoration(
          color: AppColors.secondBackground,
          borderRadius: BorderRadius.circular(10)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('My Orders'),
          IconButton(onPressed: (){
            AppNavigator.push(context, MyOrdersPage());
          }, icon: Icon(Icons.arrow_forward_ios))
        ],
      ),
    );
  }
}
