import 'package:ecommers/common/bloc/button/button_cubit.dart';
import 'package:ecommers/common/bloc/button/button_state.dart';
import 'package:ecommers/common/helper/navigator/app_navigator.dart';
import 'package:ecommers/common/widget/app_bar/basic_app_bar.dart';
import 'package:ecommers/common/widget/bottons/basic_reactive_button.dart';
import 'package:ecommers/data/auth/model/user_signin_request.dart';
import 'package:ecommers/domain/auth/usecases/sign_in_usecase.dart';
import 'package:ecommers/presentation/home/page/home_page.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../common/widget/bottons/basic_app_button.dart';
import 'forgot password.dart';

class EnterPasswordPage extends StatelessWidget {
  EnterPasswordPage({super.key, required this.email});
  final String email;
  final TextEditingController _passwordController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: MultiBlocProvider(
  providers: [
    BlocProvider(
  create: (context) => ButtonCubit(),
),

  ],
  child: BlocListener<ButtonCubit, ButtonState>(
  listener: (context, state) {
    if(state is ButtonFailure){
      var snackBar=SnackBar(content: Text(state.errorMessage),behavior: SnackBarBehavior.floating,);

      ScaffoldMessenger.of(context).showSnackBar(snackBar);


    } if(state is ButtonSuccess){
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>HomePage()), (route)=>false);

    }
  },
  child: Scaffold(
        appBar: BasicAppBar(),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 40,horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _signText(),
              SizedBox(height: 20,),
              _passwordField(),
              SizedBox(height: 20,),
              _continueButton(context),
              SizedBox(height: 20,),
              _forgotPassword(context),
            ],
          ),
        ),
      ),
),
),
    );
  }
  Widget _signText(){
    return const Text('Sign in',style: TextStyle(
      fontSize: 32,
      fontWeight: FontWeight.bold,
    ),);
  }
  Widget _passwordField(){
    return TextField(
      controller: _passwordController,
      decoration: InputDecoration(
          hintText: 'Enter Password'
      ),
    );
  }
  Widget _continueButton(BuildContext context){
    return Builder(
      builder: (context) {
        return BasicReactiveButton(onPressed: () {  context.read<ButtonCubit>().execute(useCase: SignInUseCase(),
            params: UserSignInReq(email: email, password: _passwordController.text));}, title: 'Continue',);
      }
    );
  }
  Widget _forgotPassword(BuildContext context){
    return RichText(text: TextSpan(
        children: [
          TextSpan(
              text: "Forget Password? "
          ),TextSpan(
              text: 'Reset',
              recognizer: TapGestureRecognizer()..onTap=(){AppNavigator.push(context, ForgotPasswordPage());

              },
              style: const TextStyle(fontWeight: FontWeight.bold)
          )
        ]
    ));
  }
}
