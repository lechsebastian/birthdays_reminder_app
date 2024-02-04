import 'package:bloc/bloc.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginState());

  Future<void> switchIsRegisterStatus() async {
    LoginState newState = state.copyWith(isCreatingAccount: !state.isCreatingAccount);

    emit(newState);
  }
}
