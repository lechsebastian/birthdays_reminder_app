import 'package:birthdays_reminder_app/app/cubit/root_cubit.dart';
import 'package:birthdays_reminder_app/app/features/home/home_page.dart';
import 'package:birthdays_reminder_app/app/features/login/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.black,
        ),
        useMaterial3: false,
      ),
      home: const RootPage(),
    );
  }
}

class RootPage extends StatelessWidget {
  const RootPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RootCubit()..start(),
      child: BlocListener<RootCubit, RootState>(
        listener: (context, state) {
          if (state.errorMessage.isNotEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Something went wrong: ${state.errorMessage}'),
                backgroundColor: Colors.red,
              ),
            );
          }
          if (state.isLoading) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('It\'s loading..'),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        child: BlocBuilder<RootCubit, RootState>(
          builder: (context, state) {
            final user = state.user;

            if (user == null) {
              return LoginPage();
            }
            return HomePage(user: user);
          },
        ),
      ),
    );
  }
}
