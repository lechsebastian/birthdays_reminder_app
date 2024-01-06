part of 'add_birthday_cubit.dart';

@immutable
class AddBirthdayState {
  final bool saved;
  final String errorMessage;

  const AddBirthdayState({
    this.saved = false,
    this.errorMessage = '',
  });
}
