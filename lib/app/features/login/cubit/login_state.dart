part of 'login_cubit.dart';

class LoginState {
  bool isCreatingAccount;
  String errorMessage;

  LoginState({
    this.isCreatingAccount = false,
    this.errorMessage = '',
  });

  LoginState copyWith({
    bool? isCreatingAccount,
  }) {
    return LoginState(
      isCreatingAccount: isCreatingAccount ?? this.isCreatingAccount,
    );
  }
}
