import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class BirthdaysPageContent extends StatelessWidget {
  const BirthdaysPageContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance.collection('birthdays').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text('Loading..');
          }

          final documents = snapshot.data!.docs;

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
                ],
              ],
            ),
          );
        });
  }
}
