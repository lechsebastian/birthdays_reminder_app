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
      child: BlocBuilder<RootCubit, RootState>(
        builder: (context, state) {
          switch (state.status) {
            case Status.initial:
              return const Center(
                child: Text('Initial state'),
              );
            case Status.loading:
              return const Center(
                child: CircularProgressIndicator(),
              );
            case Status.error:
            case Status.removingError:
              return Center(
                child: Text(
                  state.errorMessage ?? 'Unknown error',
                  style: TextStyle(color: Theme.of(context).colorScheme.error),
                ),
              );
            case Status.success:
              final user = state.user;

              if (user == null) {
                return LoginPage();
              }
              return HomePage(user: user);
          }
        },
      ),
    );
  }
}
