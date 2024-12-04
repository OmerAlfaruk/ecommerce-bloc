import 'package:ecommers/common/bloc/button/button_cubit.dart';
import 'package:ecommers/common/bloc/button/button_state.dart';
import 'package:ecommers/common/helper/navigator/app_navigator.dart';
import 'package:ecommers/common/widget/app_bar/basic_app_bar.dart';
import 'package:ecommers/common/widget/bottons/basic_reactive_button.dart';
import 'package:ecommers/domain/auth/usecases/send_passord_reset_email_usecase.dart';
import 'package:ecommers/presentation/auth/pages/signin/enter_password_page.dart';
import 'package:ecommers/presentation/auth/pages/signin/password_reset_email_sent.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../common/widget/bottons/basic_app_button.dart';

class ForgotPasswordPage extends StatelessWidget {
   ForgotPasswordPage({super.key});
  final  TextEditingController _emailController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
  create: (context) => ButtonCubit(),
  child: BlocListener<ButtonCubit, ButtonState>(
  listener: (context, state) {
    if(state is ButtonFailure){
      var snackBar=SnackBar(content: Text(state.errorMessage),behavior: SnackBarBehavior.floating,);

      ScaffoldMessenger.of(context).showSnackBar(snackBar);


    }
    if(state is ButtonSuccess){
      AppNavigator.push(context, PasswordResetEmailPage());
    }
  },
  child: SafeArea(
      child: Scaffold(
        appBar: const BasicAppBar(),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 40,horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _signText(),
              const SizedBox(height: 20,),
              _emailField(),
              const SizedBox(height: 20,),
              _continueButton(context),

            ],
          ),
        ),
      ),
    ),
),
);
  }
  Widget _signText(){
    return Text('Forgot Password',style: TextStyle(
      fontSize: 32,
      fontWeight: FontWeight.bold,
    ),);
  }
  Widget _emailField(){
    return TextField(
      controller: _emailController,
      decoration: InputDecoration(
          hintText: 'Enter Email',
      ),
    );
  }
  Widget _continueButton(BuildContext context){
    return Builder(
      builder: (context) {
        return BasicReactiveButton(onPressed: () {context.read<ButtonCubit>().execute(useCase: SendPasswordResetEmailUseCase(),params: _emailController.text); }, title: 'Continue',);
      }
    );
  }

}
