// ignore_for_file: sized_box_for_whitespace

import 'package:birthdays_reminder_app/app/features/home/add_birthday/cubit/add_birthday_cubit.dart';
import 'package:birthdays_reminder_app/repositories/items_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class AddBirthdayPageContent extends StatefulWidget {
  const AddBirthdayPageContent({
    super.key,
    required this.onSave,
  });

  final Function onSave;

  @override
  State<AddBirthdayPageContent> createState() => _AddBirthdayPageContentState();
}

class _AddBirthdayPageContentState extends State<AddBirthdayPageContent> {
  String name = '';
  String phoneNumber = '';
  DateTime? birthday;
  String? selectedDateFormatted;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddBirthdayCubit(ItemsRepository()),
      child: BlocListener<AddBirthdayCubit, AddBirthdayState>(
        listener: (context, state) {
          if (state.saved) {
            widget.onSave();
          }
          if (state.errorMessage.isNotEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(state.errorMessage),
              backgroundColor: Colors.red,
            ));
          }
        },
        child: BlocBuilder<AddBirthdayCubit, AddBirthdayState>(
          builder: (context, state) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // name
                    TextField(
                      onChanged: (value) {
                        setState(() {
                          name = value;
                        });
                      },
                      decoration: const InputDecoration(
                        label: Text('Name'),
                        hintText: 'Adam Małysz',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),

                    // phone number
                    TextField(
                      onChanged: (value) {
                        setState(() {
                          phoneNumber = value;
                        });
                      },
                      decoration: const InputDecoration(
                        label: Text('Phone number'),
                        hintText: '+48 533122345',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),

                    // date time picker
                    ElevatedButton(
                      onPressed: () async {
                        final selectedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now().subtract(const Duration(days: 365 * 150)),
                          lastDate: DateTime.now(),
                        );
                        birthday = selectedDate;
                        setState(() {
                          selectedDateFormatted = selectedDate == null ? null : DateFormat.yMMMMEEEEd().format(selectedDate);
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          child: Text(selectedDateFormatted ?? 'Choose birthday date', textAlign: TextAlign.center),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),

                    // save details button
                    ElevatedButton(
                      onPressed: name.isEmpty || phoneNumber.isEmpty || selectedDateFormatted == null
                          ? null
                          : () {
                              context.read<AddBirthdayCubit>().add(name, phoneNumber, birthday!);
                            },
                      child: const Text('Add'),
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
