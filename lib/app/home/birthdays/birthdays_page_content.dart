import 'package:birthdays_reminder_app/app/home/birthdays/cubit/birthdays_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BirthdaysPageContent extends StatelessWidget {
  const BirthdaysPageContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      // w emit start trzeba obliczyc/pokazywac liczbe dni do urodzin, bo wtedy bd odswiezane przy przejsciu do ekranu
      create: (context) => BirthdaysCubit()..start(),
      child: BlocBuilder<BirthdaysCubit, BirthdaysState>(
        builder: (context, state) {
          if (state.errorMessage.isNotEmpty) {
            return Center(child: Text('Something went wrong: ${state.errorMessage}'));
          }
          if (state.isLoading) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 12),
                  Text('Loading..'),
                ],
              ),
            );
          }

          final documents = state.documents;

          return Padding(
            padding: const EdgeInsets.all(24),
            child: ListView(
              children: [
                for (final document in documents) ...[
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.circular(12)),
                                    padding: const EdgeInsets.all(8),
                                    child: const Icon(Icons.person, size: 36),
                                  ),
                                  const SizedBox(width: 14),
                                  Column(
                                    children: [
                                      Text(
                                        document['name'],
                                        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        document['date'],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Text(
                            document['days'].toString(),
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                ],
              ],
            ),
          );
        },
      ),
    );
  }
}
