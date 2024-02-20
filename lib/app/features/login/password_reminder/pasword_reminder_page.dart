import 'package:birthdays_reminder_app/app/features/login/password_reminder/cubit/password_reminder_cubit.dart';
import 'package:birthdays_reminder_app/themes/my_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PaswordReminderPage extends StatelessWidget {
  PaswordReminderPage({Key? key}) : super(key: key);

  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PasswordReminderCubit(),
      child: BlocListener<PasswordReminderCubit, PasswordReminderState>(
        listener: (context, state) {
          if (state.isSend) {
            Navigator.of(context).pop();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Text('The password has been sent'),
                backgroundColor: MyColor().myPrimaryColor,
              ),
            );
          }
          if (state.errorMessage.isNotEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Something went wrong: ${state.errorMessage}'),
                backgroundColor: const Color.fromARGB(255, 31, 21, 20),
              ),
            );
          }
        },
        child: BlocBuilder<PasswordReminderCubit, PasswordReminderState>(
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                foregroundColor: MyColor().myPrimaryColor,
                backgroundColor: Colors.transparent,
                elevation: 0,
              ),
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Reset password',
                      style: TextStyle(fontSize: 42, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 12),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: TextField(
                        controller: emailController,
                        decoration: const InputDecoration(
                          hintText: 'user@gmail.com',
                          labelText: 'Email',
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton(
                      onPressed: () {
                        context.read<PasswordReminderCubit>().resetPassword(email: emailController.text);
                      },
                      child: const Text('Reset'),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
