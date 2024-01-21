import 'package:birthdays_reminder_app/models/item_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ItemsRepository {
  Stream<List<ItemModel>> getItemsStream() {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) {
      throw Exception('User is not logged in');
    }

    return FirebaseFirestore.instance.collection('users').doc(userId).collection('birthdays').snapshots().map(
      (querySnapshot) {
        return querySnapshot.docs.map(
          (doc) {
            return ItemModel(
              id: doc.id,
              name: doc['name'],
              phoneNumber: doc['phoneNumber'],
              birthday: (doc['birthday'] as Timestamp).toDate(),
            );
          },
        ).toList();
      },
    );
  }

  Future<void> delete({required String id}) {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) {
      throw Exception('User is not logged in');
    }

    return FirebaseFirestore.instance.collection('users').doc(userId).collection('birthdays').doc(id).delete();
  }

  Future<ItemModel> get({required String id}) async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) {
      throw Exception('User is not logged in');
    }

    final doc = await FirebaseFirestore.instance.collection('users').doc(userId).collection('birthdays').doc(id).get();

    return ItemModel(
      id: doc.id,
      name: doc['name'],
      phoneNumber: doc['phoneNumber'],
      birthday: (doc['birthday'] as Timestamp).toDate(),
    );
  }

  Future<void> add(
    String name,
    String phoneNumber,
    DateTime birthday,
  ) async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) {
      throw Exception('User is not logged in');
    }

    await FirebaseFirestore.instance.collection('users').doc(userId).collection('birthdays').add(
      {
        'name': name,
        'phoneNumber': phoneNumber,
        'birthday': birthday,
      },
    );
  }
}
