import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'birthdays_state.dart';

class BirthdaysCubit extends Cubit<BirthdaysState> {
  BirthdaysCubit()
      : super(
          const BirthdaysState(
            documents: [],
            isLoading: false,
            errorMessage: '',
          ),
        );

  StreamSubscription? _streamSubscription;

  Future<void> start() async {
    emit(
      const BirthdaysState(
        documents: [],
        isLoading: true,
        errorMessage: '',
      ),
    );

    _streamSubscription = FirebaseFirestore.instance.collection('birthdays').orderBy('days').snapshots().listen(
      (event) {
        emit(
          BirthdaysState(
            documents: event.docs,
            isLoading: false,
            errorMessage: '',
          ),
        );
      },
    )..onError((error) {
        emit(
          BirthdaysState(
            documents: const [],
            isLoading: false,
            errorMessage: error.toString(),
          ),
        );
      });
  }

  Future<void> deleteDocument({required String documentID}) async {
    try {
      await FirebaseFirestore.instance.collection('birthdays').doc(documentID).delete();
    } catch (error) {
      emit(
        const BirthdaysState(removingErrorOccured: true),
      );
      start();
    }
  }

  // Future<void> loadBirthdays() async {
  //   final snapshot = await FirebaseFirestore.instance.collection('birthdays').get();

  //   final people = snapshot.documents.map((doc) {
  //     final data = doc.data;
  //     final birthday = (data['data'] as Timestamp).toDate();
  //     final name = data['imie'];
  //     return Person(name: name, birthday: birthday);
  //   }).toList();

  //   people.sort((a, b) => _daysUntilNextBirthday(a.birthday).compareTo(_daysUntilNextBirthday(b.birthday)));

  //   emit(people);
  // }

  // int _daysUntilNextBirthday(DateTime birthday) {
  //   final now = DateTime.now();
  //   final nextBirthday = DateTime(now.year, birthday.month, birthday.day);
  //   if (nextBirthday.isBefore(now)) {
  //     return nextBirthday.add(const Duration(days: 365)).difference(now).inDays;
  //   } else {
  //     return nextBirthday.difference(now).inDays;
  //   }
  // }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
