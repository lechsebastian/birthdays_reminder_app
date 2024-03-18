import 'dart:async';
import 'package:birthdays_reminder_app/app/core/enums.dart';
import 'package:birthdays_reminder_app/models/item_model.dart';
import 'package:birthdays_reminder_app/repositories/items_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'birthdays_state.dart';

class BirthdaysCubit extends Cubit<BirthdaysState> {
  BirthdaysCubit(this._itemsRepository) : super(const BirthdaysState());

  final ItemsRepository _itemsRepository;
  StreamSubscription? _streamSubscription;

  Future<void> start() async {
    emit(
      const BirthdaysState(
        items: [],
        status: Status.loading,
        errorMessage: '',
      ),
    );

    _streamSubscription = _itemsRepository.getItemsStream().listen(
      (items) {
        items.sort((a, b) => _daysUntilNextBirthday(a.birthday).compareTo(_daysUntilNextBirthday(b.birthday)));

        emit(
          BirthdaysState(
            items: items,
            status: Status.success,
            errorMessage: '',
          ),
        );
      },
    )..onError((error) {
        emit(
          BirthdaysState(
            items: const [],
            status: Status.error,
            errorMessage: error.toString(),
          ),
        );
      });
  }

  Future<void> deleteDocument({required String documentID}) async {
    try {
      await _itemsRepository.delete(id: documentID);
    } catch (error) {
      emit(
        const BirthdaysState(status: Status.removingError),
      );
      start();
    }
  }

  int _daysUntilNextBirthday(DateTime birthday) {
    final now = DateTime.now();
    final nextBirthday = DateTime(now.year, birthday.month, birthday.day);
    if (nextBirthday.isBefore(now)) {
      return nextBirthday.add(const Duration(days: 365)).difference(now).inDays;
    } else {
      return nextBirthday.difference(now).inDays;
    }
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
