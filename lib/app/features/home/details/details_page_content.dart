import 'package:birthdays_reminder_app/app/features/home/details/cubit/details_cubit.dart';
import 'package:birthdays_reminder_app/repositories/items_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailsPageContent extends StatelessWidget {
  const DetailsPageContent({
    super.key,
    required this.id,
  });

  final String id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
      ),
      body: BlocProvider(
        create: (context) => DetailsCubit(ItemsRepository())..getItemWithID(id),
        child: BlocBuilder<DetailsCubit, DetailsState>(
          builder: (context, state) {
            final itemModel = state.itemModel;

            if (itemModel == null) {
              return const CircularProgressIndicator();
            }
            var days = int.parse(itemModel.daysUntilNextBirthday());

            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // photo
                  Container(
                    decoration: BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.circular(12)),
                    padding: const EdgeInsets.all(8),
                    child: const Icon(Icons.person, size: 144),
                  ),

                  // name
                  const SizedBox(height: 16),
                  Text(
                    itemModel.name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  // days to birthday
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.cake),
                      const SizedBox(width: 4),
                      Text(itemModel.daysUntilNextBirthday()),
                      Text(days > 0 ? ' days to birthday' : ' day to birthday'),
                    ],
                  ),

                  // birthday and phone number
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // icon + birthday
                      Row(
                        children: [
                          const Icon(Icons.calendar_today_outlined),
                          const SizedBox(width: 8),
                          Text(
                            itemModel.birthday.toString(),
                          ),
                        ],
                      ),

                      // icon + phonenumber
                      const SizedBox(width: 8),
                      Row(
                        children: [
                          const Icon(Icons.phone_android),
                          const SizedBox(width: 8),
                          Text(itemModel.phoneNumber),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
