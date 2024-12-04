import 'package:ecommers/common/helper/navigator/app_navigator.dart';
import 'package:ecommers/common/widget/app_bar/basic_app_bar.dart';
import 'package:ecommers/common/widget/bottons/basic_reactive_button.dart';
import 'package:ecommers/presentation/auth/pages/signin/enter_password_page.dart';
import 'package:ecommers/presentation/auth/pages/signup/sign_up.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../../../common/widget/bottons/basic_app_button.dart';

class SignInPage extends StatelessWidget {
  SignInPage({super.key});
  final TextEditingController _emailController = TextEditingController();

  // Regular expression for email validation
  final RegExp _emailRegex = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: BasicAppBar(
          hideBack: true,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _signText(),
              SizedBox(height: 20),
              _emailField(),
              SizedBox(height: 20),
              _continueButton(context),
              SizedBox(height: 20),
              _createAccount(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _signText() {
    return Text(
      'Sign in',
      style: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _emailField() {
    return TextField(
      controller: _emailController,
      decoration: InputDecoration(
        hintText: 'Enter Email',
      ),
    );
  }

  Widget _continueButton(BuildContext context) {
    return BasicReactiveButton(
      onPressed: () {
        if (_emailRegex.hasMatch(_emailController.text)) {
          // If the email is valid, navigate to the next page
          AppNavigator.push(
            context,
            EnterPasswordPage(email: _emailController.text),
          );
        } else {
          // Show an error message if the email is invalid
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Please enter a valid email address.')),
          );
        }
      },
      title: 'Continue',
    );
  }

  Widget _createAccount(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(text: "Don't you have an account? "),
          TextSpan(
            text: 'Create one',
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                AppNavigator.push(context, SignUpPage());
              },
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
