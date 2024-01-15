import 'package:birthdays_reminder_app/app/features/home/birthdays/cubit/birthdays_cubit.dart';
import 'package:birthdays_reminder_app/app/features/home/details/details_page_content.dart';
import 'package:birthdays_reminder_app/models/item_model.dart';
import 'package:birthdays_reminder_app/repositories/items_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BirthdaysPageContent extends StatelessWidget {
  const BirthdaysPageContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BirthdaysCubit(ItemsRepository())..start(),
      child: BlocListener<BirthdaysCubit, BirthdaysState>(
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
        child: BlocBuilder<BirthdaysCubit, BirthdaysState>(
          builder: (context, state) {
            final itemModels = state.items;
            return Padding(
              padding: const EdgeInsets.all(24),
              child: ListView(
                children: [
                  for (final itemModel in itemModels) ...[
                    _ListViewItem(itemModel: itemModel),
                    const SizedBox(
                      height: 24,
                    ),
                  ],
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class _ListViewItem extends StatelessWidget {
  const _ListViewItem({
    required this.itemModel,
  });

  final ItemModel itemModel;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => DetailsPageContent(id: itemModel.id),
        ));
      },
      child: Dismissible(
        key: ValueKey(itemModel.id),
        background: const DecoratedBox(
          decoration: BoxDecoration(
            color: Colors.red,
          ),
          child: Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: EdgeInsets.only(right: 32.0),
              child: Icon(
                Icons.delete,
              ),
            ),
          ),
        ),
        confirmDismiss: (direction) async {
          return direction == DismissDirection.endToStart;
        },
        onDismissed: (direction) {
          context.read<BirthdaysCubit>().deleteDocument(documentID: itemModel.id);
        },
        child: Container(
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // name
                            Text(
                              itemModel.name,
                              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                            ),

                            // birthday date
                            const SizedBox(height: 2),
                            Text(
                              itemModel.nextBirthdayFormatted(),
                              style: const TextStyle(fontSize: 13),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                Column(
                  children: [
                    Row(
                      children: [
                        // how many days
                        Text(
                          itemModel.daysUntilNextBirthday(),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          int.parse(itemModel.daysUntilNextBirthday()) > 0 ? ' days' : 'day',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),

                    // turns ages
                    Text('Turns ${itemModel.turnsAges()}')
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
