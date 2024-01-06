import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'add_birthday_state.dart';

class AddBirthdayCubit extends Cubit<AddBirthdayState> {
  AddBirthdayCubit() : super(const AddBirthdayState());

  Future<void> add(
    String name,
    String phoneNumber,
    DateTime releaseDate,
  ) async {
    try {
        FirebaseFirestore.instance.collection('birthdays').add(
          {
            'name': name,
            'phoneNumber': phoneNumber,
            'days': releaseDate,
          },
        );
        emit(const AddBirthdayState(saved: true));
    } catch (error) {
      emit(AddBirthdayState(errorMessage: error.toString()));
    }
  }
}
