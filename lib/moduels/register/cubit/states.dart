abstract class RegisterStates {}

class RegisterInitalState extends RegisterStates {}

class RegisterLoadingState extends RegisterStates {}

class RegisterSuccessState extends RegisterStates {}

class RegisterErorrState extends RegisterStates {
  final String error;

  RegisterErorrState(this.error);
}

class RgisterChangePasswordVisibilityState extends RegisterStates {}
