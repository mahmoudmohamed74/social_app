// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/moduels/login/cubit/states.dart';

class LoginCuibt extends Cubit<LoginStates> {
  LoginCuibt() : super(LoginInitalState());
  static LoginCuibt get(context) => BlocProvider.of(context);

  void userLogin({
    required String email,
    required String password,
  }) {
    emit(LoginLoadingState());
    FirebaseAuth.instance
        .signInWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) {
      print(value.user!.email);
      print(value.user!.uid);

      emit(LoginSuccessState(value.user!.uid));
    }).catchError((error) {
      print(error.toString());
      emit(LoginErorrState(error.toString()));
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;
  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix = isPassword ? Icons.visibility_outlined : Icons.visibility_off;

    emit(
      ChangePasswordVisibilityState(),
    );
  }
}
