import 'package:ecommers/core/config/assets/app_vectors.dart';
import 'package:ecommers/core/config/theme/app_colors.dart';
import 'package:ecommers/presentation/auth/pages/signin/singin.dart';
import 'package:ecommers/presentation/home/page/home_page.dart';
import 'package:ecommers/presentation/splash/bloc/splash_cubit.dart';
import 'package:ecommers/presentation/splash/bloc/splash_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashCubit, SplashState>(
      listener: (context, state) {
        if(state is Unauthenticated){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>SignInPage()));
        }
        if(state is Authenticated){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>const HomePage()));
        }

      },
      child: Scaffold(
        backgroundColor: AppColors.primary,
        body: Center(
          child: SvgPicture.asset(AppVectors.logo),
        ),
      ),
    );
  }
}
