import 'package:birthdays_reminder_app/repositories/items_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'add_birthday_state.dart';

class AddBirthdayCubit extends Cubit<AddBirthdayState> {
  AddBirthdayCubit(this._itemsRepository) : super(const AddBirthdayState());

  final ItemsRepository _itemsRepository;

  Future<void> add(
    String name,
    String phoneNumber,
    DateTime birthday,
  ) async {
    try {
      _itemsRepository.add(name, phoneNumber, birthday);
      emit(const AddBirthdayState(saved: true));
    } catch (error) {
      emit(AddBirthdayState(errorMessage: error.toString()));
    }
  }
}
