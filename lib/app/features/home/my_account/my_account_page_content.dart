import 'package:birthdays_reminder_app/app/cubit/root_cubit.dart';
import 'package:birthdays_reminder_app/themes/my_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyAccountPageContent extends StatefulWidget {
  const MyAccountPageContent({
    super.key,
    required this.email,
  });

  final String? email;

  @override
  State<MyAccountPageContent> createState() => _MyAccountPageContentState();
}

class _MyAccountPageContentState extends State<MyAccountPageContent> {
  bool _switchValue = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: MyColor().myColor,
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            onPressed: () async {
              context.read<RootCubit>().signOut();
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile info
            const Text('Profile', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Row(
              children: [
                const Text('You are logged in as '),
                Text(
                  '${widget.email}',
                  style: TextStyle(color: MyColor().myColor, fontWeight: FontWeight.bold),
                )
              ],
            ),
            const SizedBox(height: 24),

            // Settings info
            const Text('Settings', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Dark mode'),
                Switch(
                    value: _switchValue,
                    onChanged: (value) {
                      setState(() {
                        _switchValue = value;
                      });
                    })
              ],
            )
          ],
        ),
      ),
    );
  }
}
