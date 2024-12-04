import 'package:ecommers/common/helper/navigator/app_navigator.dart';
import 'package:ecommers/presentation/home/widgets/categories.dart';
import 'package:ecommers/presentation/home/widgets/get_new_in.dart';
import 'package:ecommers/presentation/home/widgets/header.dart';
import 'package:ecommers/presentation/home/widgets/top_selling.dart';
import 'package:ecommers/presentation/home/widgets/search.dart';
import 'package:ecommers/presentation/search/page/search_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 15),
         child: Column(children: [
            const Header(),
            const SizedBox(height: 15,),
            const SearchField(),
           const SizedBox(height: 15,),
            const Categories(),
           const SizedBox(height: 15,),
           const TopSelling() ,
           const SizedBox(height: 15,),
           const NewIn()
          ],),
        
        ),
      ),

    );
  }
}
