import 'package:birthdays_reminder_app/app/cubit/root_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyAccountPageContent extends StatelessWidget {
  const MyAccountPageContent({
    super.key,
    required this.email,
  });

  final String? email;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('You are logged in as $email'),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () async {
              context.read<RootCubit>().signOut();
            },
            child: const Text('Log out'),
          ),
        ],
      ),
    );
  }
}
