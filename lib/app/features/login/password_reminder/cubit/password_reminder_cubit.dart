import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'password_reminder_state.dart';

class PasswordReminderCubit extends Cubit<PasswordReminderState> {
  PasswordReminderCubit() : super(PasswordReminderState());

  Future<void> resetPassword({required String email}) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      emit(PasswordReminderState(isSend: true));
    } catch (error) {
      emit(PasswordReminderState(errorMessage: error.toString()));
    }
  }
}
