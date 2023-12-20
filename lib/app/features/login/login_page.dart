import 'package:birthdays_reminder_app/app/cubit/root_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  LoginPage({
    super.key,
  });

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var errorMessage = '';
  var isCreatingAccount = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.lock, size: 108),
              const SizedBox(height: 12),
              const Text(
                'Welcome!',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Text(
                isCreatingAccount == true ? 'It is nice to see you here' : 'It is nice to see you again',
                style: const TextStyle(
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: widget.emailController,
                decoration: const InputDecoration(label: Text('email')),
              ),
              TextField(
                controller: widget.passwordController,
                decoration: const InputDecoration(label: Text('password')),
                obscureText: true,
              ),
              const SizedBox(height: 12),
              Text(errorMessage),
              const SizedBox(height: 12),
              ElevatedButton(
                  onPressed: () {
                    if (isCreatingAccount) {
                      try {
                        context.read<RootCubit>().register(email: widget.emailController.text, password: widget.passwordController.text);
                      } catch (error) {
                        setState(() {
                          errorMessage = 'Error occured: ${error.toString()}';
                        });
                      }
                    } else {
                      try {
                        context.read<RootCubit>().signIn(email: widget.emailController.text, password: widget.passwordController.text);
                      } catch (error) {
                        setState(() {
                          errorMessage = 'Error occured: ${error.toString()}';
                        });
                      }
                    }
                  },
                  child: Text(isCreatingAccount == true ? 'Register' : 'Log in')),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(isCreatingAccount == true ? 'Already have an account?' : 'Not a member?'),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        isCreatingAccount = !isCreatingAccount;
                      });
                    },
                    child: Text(
                      isCreatingAccount == true ? 'Log in' : 'Register now',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
