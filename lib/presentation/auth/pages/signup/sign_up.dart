import 'package:ecommers/common/helper/navigator/app_navigator.dart';
import 'package:ecommers/common/widget/app_bar/basic_app_bar.dart';
import 'package:ecommers/common/widget/bottons/basic_reactive_button.dart';
import 'package:ecommers/data/auth/model/user_creation_req.dart';
import 'package:ecommers/presentation/auth/pages/signin/enter_password_page.dart';
import 'package:ecommers/presentation/auth/pages/signin/singin.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../../../common/widget/bottons/basic_app_button.dart';
import 'age_and_gender_selection.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({super.key});

  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: BasicAppBar(),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _signText(),
              SizedBox(
                height: 20,
              ),
              _firstNameField(),
              SizedBox(
                height: 20,
              ),
              _lastNameField(),
              SizedBox(
                height: 20,
              ),
              _emailField(),
              SizedBox(
                height: 20,
              ),
              _passwordField(),
              SizedBox(
                height: 20,
              ),
              _continueButton(context),
              SizedBox(
                height: 20,
              ),
              _createAccount(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _signText() {
    return Text(
      'Create Account',
      style: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _firstNameField() {
    return TextField(
      controller: _firstNameController,
      decoration: InputDecoration(hintText: 'Enter First Name'),
    );
  }

  Widget _lastNameField() {
    return TextField(
      controller: _lastNameController,
      decoration: InputDecoration(hintText: 'Enter Last Name'),
    );
  }

  Widget _emailField() {
    return TextField(
      controller: _emailController,
      decoration: InputDecoration(hintText: 'Enter Email'),
    );
  }

  Widget _passwordField() {
    return TextField(
      controller: _passwordController,
      decoration: InputDecoration(hintText: 'Enter Password'),
    );
  }

  Widget _continueButton(BuildContext context) {
    return BasicReactiveButton(
      onPressed: () {
        AppNavigator.push(
            context,
            GenderAndAgeSelectionPage(
              userCreationReq: UserCreationReq(
                  firstName: _firstNameController.text,
                  lastName: _lastNameController.text,
                  email: _emailController.text,
                  password: _passwordController.text),
            ));
      },
      title: 'Continue',
    );
  }

  Widget _createAccount(BuildContext context) {
    return RichText(
        text: TextSpan(children: [
      TextSpan(text: "Already have an account? "),
      TextSpan(
          text: 'Sign In',
          recognizer: TapGestureRecognizer()
            ..onTap = () {
              AppNavigator.push(context, SignInPage());
            },
          style: TextStyle(fontWeight: FontWeight.bold))
    ]));
  }
}
