part of 'birthdays_cubit.dart';

@immutable
class BirthdaysState {
  final List<QueryDocumentSnapshot<Map<String, dynamic>>> documents;
  final bool isLoading;
  final String errorMessage;

  const BirthdaysState({
    required this.documents,
    required this.isLoading,
    required this.errorMessage,
  });
}
