import 'dart:async';
import 'package:birthdays_reminder_app/models/item_model.dart';
import 'package:birthdays_reminder_app/repositories/items_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'birthdays_state.dart';

class BirthdaysCubit extends Cubit<BirthdaysState> {
  BirthdaysCubit(this._itemsRepository)
      : super(
          const BirthdaysState(
            items: [],
            isLoading: false,
            errorMessage: '',
          ),
        );

  final ItemsRepository _itemsRepository;
  StreamSubscription? _streamSubscription;

  Future<void> start() async {
    emit(
      const BirthdaysState(
        items: [],
        isLoading: true,
        errorMessage: '',
      ),
    );

    _streamSubscription = _itemsRepository.getItemsStream().listen(
      (items) {
        items.sort((a, b) => _daysUntilNextBirthday(a.birthday).compareTo(_daysUntilNextBirthday(b.birthday)));

        emit(
          BirthdaysState(
            items: items,
            isLoading: false,
            errorMessage: '',
          ),
        );
      },
    )..onError((error) {
        emit(
          BirthdaysState(
            items: const [],
            isLoading: false,
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
        const BirthdaysState(removingErrorOccured: true),
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
