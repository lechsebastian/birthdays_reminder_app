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
        onTap: () {},
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
