part of 'birthdays_cubit.dart';

@immutable
class BirthdaysState {
  final List<QueryDocumentSnapshot<Map<String, dynamic>>>? documents;
  final bool isLoading;
  final String errorMessage;
  final bool removingErrorOccured;

  const BirthdaysState({
    this.documents,
    this.isLoading = false,
    this.errorMessage = '',
    this.removingErrorOccured = false,
  });
}
