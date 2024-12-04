import 'package:ecommers/common/widget/app_bar/basic_app_bar.dart';
import 'package:ecommers/presentation/setting/widgets/my_favorite_title.dart';
import 'package:ecommers/presentation/setting/widgets/my_orders_title.dart';
import 'package:flutter/material.dart';



class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppBar(
        title: Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            MyFavoriteTitle(),
            SizedBox(height: 20,),
            MyOrdersTitle()
          ],

        ),
      ),
    );
  }
}
