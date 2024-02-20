import 'package:birthdays_reminder_app/app/cubit/root_cubit.dart';
import 'package:birthdays_reminder_app/app/features/login/cubit/login_cubit.dart';
import 'package:birthdays_reminder_app/app/features/login/login_page_widgets/signin_or_register_widget_builder.dart';
import 'package:birthdays_reminder_app/themes/my_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  LoginPage({
    super.key,
  });

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocBuilder<LoginCubit, LoginState>(
        builder: (context, state) {
          return Scaffold(
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  children: [
                    // Calendar icon
                    const SizedBox(height: 30),
                    const Icon(Icons.calendar_month, size: 108),
                    const SizedBox(height: 30),

                    // Sign in / register information
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        state.isCreatingAccount == true ? 'Register' : 'Sign in',
                        style: const TextStyle(fontSize: 42, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(height: 6),

                    // Text switching between sign in / register function
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Row(
                        children: [
                          Text(
                            state.isCreatingAccount == true ? 'Already have an account?  ' : 'Not a member?  ',
                            style: TextStyle(fontSize: 10, color: Colors.grey[600]),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                state.isCreatingAccount = !state.isCreatingAccount;
                                widget.emailController.clear();
                                widget.passwordController.clear();
                                widget.confirmPasswordController.clear();
                              });
                            },
                            child: Text(
                              state.isCreatingAccount == true ? 'Log in' : 'Register',
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10, color: MyColor().myPrimaryColor),
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Email textfield
                    TextField(
                      controller: widget.emailController,
                      decoration: const InputDecoration(label: Text('Email')),
                    ),

                    // Password textfield
                    TextField(
                      controller: widget.passwordController,
                      obscureText: _obscureText,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscureText ? Icons.visibility : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setState(
                              () {
                                _obscureText = !_obscureText;
                              },
                            );
                          },
                        ),
                      ),
                    ),

                    // Forgotten password button or confirm password TextField
                    SignInOrRegisterWidgetBuilder(
                      isCreatingAccount: state.isCreatingAccount,
                      confirmPasswordController: widget.confirmPasswordController,
                      onChanged: (value) {
                        setState(() {
                          widget.confirmPasswordController.text = value;
                        });
                      },
                    ),
                    const SizedBox(height: 12),

                    // Log in / register button to database
                    ElevatedButton(
                        onPressed: () {
                          if (state.isCreatingAccount) {
                            if (widget.passwordController.text == widget.confirmPasswordController.text) {
                              context
                                  .read<RootCubit>()
                                  .register(email: widget.emailController.text, password: widget.passwordController.text);
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Passwords are not similar'),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            }
                          } else {
                            context.read<RootCubit>().signIn(email: widget.emailController.text, password: widget.passwordController.text);
                          }
                        },
                        child: Text(state.isCreatingAccount == true ? 'Register' : 'Log in')),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
