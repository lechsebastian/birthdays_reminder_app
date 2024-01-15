part of 'birthdays_cubit.dart';

@immutable
class BirthdaysState {
  const BirthdaysState({
    this.items = const [],
    this.isLoading = false,
    this.errorMessage = '',
    this.removingErrorOccured = false,
  });

  final List<ItemModel> items;
  final bool isLoading;
  final String errorMessage;
  final bool removingErrorOccured;
}
