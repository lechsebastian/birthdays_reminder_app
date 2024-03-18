import 'dart:async';

import 'package:birthdays_reminder_app/app/core/enums.dart';
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'root_state.dart';

class RootCubit extends Cubit<RootState> {
  RootCubit() : super(const RootState());

  StreamSubscription? _streamSubscription;

  Future<void> signOut() async {
    FirebaseAuth.instance.signOut();
  }

  Future<void> register({required String email, required String password}) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (error) {
      emit(RootState(user: null, status: Status.error, errorMessage: error.toString()));
    }
  }

  Future<void> signIn({required String email, required String password}) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (error) {
      emit(RootState(user: null, status: Status.error, errorMessage: error.toString()));
    }
  }

  Future<void> start() async {
    emit(
      const RootState(
        user: null,
        status: Status.loading,
        errorMessage: '',
      ),
    );

    _streamSubscription = FirebaseAuth.instance.authStateChanges().listen((event) {
      emit(
        RootState(
          user: event,
          status: Status.success,
          errorMessage: '',
        ),
      );
    })
      ..onError((error) {
        emit(
          RootState(
            user: null,
            status: Status.error,
            errorMessage: error.toString(),
          ),
        );
      });
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
