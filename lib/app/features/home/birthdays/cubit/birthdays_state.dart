part of 'birthdays_cubit.dart';

@immutable
class BirthdaysState {
  const BirthdaysState({
    this.items = const [],
    this.status = Status.initial,
    this.errorMessage,
  });

  final List<ItemModel> items;
  final Status status;
  final String? errorMessage;
}
