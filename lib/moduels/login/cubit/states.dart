abstract class LoginStates {}

class LoginInitalState extends LoginStates {}

class LoginLoadingState extends LoginStates {}

class LoginSuccessState extends LoginStates {}

class LoginErorrState extends LoginStates {
  final String error;

  LoginErorrState(this.error);
}

class ChangePasswordVisibilityState extends LoginStates {}
