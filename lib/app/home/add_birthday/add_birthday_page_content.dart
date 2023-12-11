import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddBirthdayPageContent extends StatefulWidget {
  const AddBirthdayPageContent({
    super.key,
  });

  @override
  State<AddBirthdayPageContent> createState() => _AddBirthdayPageContentState();
}

class _AddBirthdayPageContentState extends State<AddBirthdayPageContent> {
  var name = '';
  var date = '';
  int daysRandom = Random().nextInt(100);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
            TextField(
              onChanged: (value) {
                setState(() {
                  date = value;
                });
              },
              decoration: const InputDecoration(
                label: Text('Birthday'),
                hintText: '31-12-1999',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            ElevatedButton(
              onPressed: () {
                FirebaseFirestore.instance.collection('birthdays').add({
                  'name': name,
                  'date': date,
                  'days': daysRandom,
                });
              },
              child: const Text('Add'),
            ),
          ],
        ),
      ),
    );
  }
}
