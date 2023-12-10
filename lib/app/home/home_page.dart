import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
    required this.user,
  });

  final User user;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(builder: (context) {
        if (currentIndex == 0) {
          return const BirthdaysPageContent();
        }
        if (currentIndex == 1) {
          return const AddBirthdayPageContent();
        }
        return MyAccountPageContent(email: widget.user.email);
      }),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (value) {
          setState(() {
            currentIndex = value;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month),
            label: 'Birthdays',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Add',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'My account',
          ),
        ],
      ),
    );
  }
}

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
              await FirebaseAuth.instance.signOut();
            },
            child: const Text('Log out'),
          ),
        ],
      ),
    );
  }
}

class AddBirthdayPageContent extends StatelessWidget {
  const AddBirthdayPageContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Add birthday'),
    );
  }
}

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
                  Padding(
                    padding: const EdgeInsets.all(8.0),
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
                ],
              ],
            ),
          );
        });
  }
}
