import 'package:birthdays_reminder_app/app/features/login/password_reminder/pasword_reminder_page.dart';
import 'package:birthdays_reminder_app/themes/my_color.dart';
import 'package:flutter/material.dart';

class ForgottenPasswordText extends StatelessWidget {
  const ForgottenPasswordText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => PaswordReminderPage()));
        },
        child: Padding(
          padding: const EdgeInsets.only(top: 12),
          child: Text(
            'Forgotten password?',
            style: TextStyle(color: MyColor().myColor, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
