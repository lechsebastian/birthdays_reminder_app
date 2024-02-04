part of 'login_cubit.dart';

class LoginState {
  bool isCreatingAccount;

  LoginState({
    this.isCreatingAccount = false,
  });

  LoginState copyWith({
    bool? isCreatingAccount,
  }) {
    return LoginState(
      isCreatingAccount: isCreatingAccount ?? this.isCreatingAccount,
    );
  }
}
