import 'package:birthdays_reminder_app/app/features/login/login_page_widgets/confirm_password.dart';
import 'package:birthdays_reminder_app/app/features/login/login_page_widgets/forgotten_password.dart';
import 'package:flutter/material.dart';

class SignInOrRegisterWidgetBuilder extends StatelessWidget {
  const SignInOrRegisterWidgetBuilder({
    Key? key,
    required this.isCreatingAccount,
    required this.confirmPasswordController,
    required this.onChanged,
  }) : super(key: key);

  final bool isCreatingAccount;
  final TextEditingController confirmPasswordController;
  final void Function(String) onChanged;

  @override
  Widget build(BuildContext context) {
    if (!isCreatingAccount) {
      return const ForgottenPasswordText();
    } else {
      return ConfirmPasswordTextField(confirmPasswordController: confirmPasswordController, onChanged: onChanged);
    }
  }
}