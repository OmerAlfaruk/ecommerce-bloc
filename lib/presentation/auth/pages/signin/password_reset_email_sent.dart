import 'package:ecommers/common/helper/navigator/app_navigator.dart';
import 'package:ecommers/common/widget/bottons/basic_app_button.dart';
import 'package:ecommers/common/widget/bottons/basic_reactive_button.dart';
import 'package:ecommers/core/config/assets/app_vectors.dart';
import 'package:ecommers/presentation/auth/pages/signin/singin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class PasswordResetEmailPage extends StatelessWidget {
  const PasswordResetEmailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _emailSending(),
          const SizedBox(
            height: 30,
          ),
          _sentEmail(),
          const SizedBox(
            height: 30,
          ),
          _returnToLoginButton(context)
        ],
      ),
    );
  }

  Widget _emailSending() {
    return Center(
      child: SvgPicture.asset(AppVectors.emailSending),
    );
  }

  Widget _sentEmail() {
    return const Center(
      child: Text('We Sent you an Email to reset your password.'),
    );
  }

  Widget _returnToLoginButton(BuildContext context) {
    return BasicReactiveButton(
        onPressed: () {
          AppNavigator.push(context, SignInPage());
        },
        title: 'Return to Login');
  }
}
