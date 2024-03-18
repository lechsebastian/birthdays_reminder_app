import 'package:birthdays_reminder_app/app/core/enums.dart';
import 'package:birthdays_reminder_app/app/cubit/root_cubit.dart';
import 'package:birthdays_reminder_app/app/features/home/home_page.dart';
import 'package:birthdays_reminder_app/app/features/login/login_page.dart';
import 'package:birthdays_reminder_app/themes/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Provider.of<ThemeProvider>(context).getTheme(),
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
      child: BlocConsumer<RootCubit, RootState>(
        listener: (context, state) {
          if (state.status == Status.error) {
            final errorMessage = state.errorMessage ?? 'Unknown error';
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Something went wrong: $errorMessage'),
                backgroundColor: Colors.red,
              ),
            );
          }
          if (state.status == Status.loading) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('It\'s loading..'),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          final user = state.user;

          if (user == null) {
            return LoginPage();
          }
          return HomePage(user: user);
        },
      ),
    );
  }
}
