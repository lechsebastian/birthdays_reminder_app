import 'package:birthdays_reminder_app/models/item_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ItemsRepository {
  Stream<List<ItemModel>> getItemsStream() {
    return FirebaseFirestore.instance.collection('birthdays').snapshots().map(
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
    return FirebaseFirestore.instance.collection('birthdays').doc(id).delete();
  }

  Future<ItemModel> get({required String id}) async {
    final doc = await FirebaseFirestore.instance.collection('birthdays').doc(id).get();

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
    await FirebaseFirestore.instance.collection('birthdays').add(
      {
        'name': name,
        'phoneNumber': phoneNumber,
        'birthday': birthday,
      },
    );
  }
}
