abstract class RegisterStates {}

class RegisterInitalState extends RegisterStates {}

class RegisterLoadingState extends RegisterStates {}

class RegisterSuccessState extends RegisterStates {}

class RegisterErorrState extends RegisterStates {
  final String error;

  RegisterErorrState(this.error);
}

class CreateUserSuccessState extends RegisterStates {}

class CreateUserErrorState extends RegisterStates {
  final String error;

  CreateUserErrorState(this.error);
}

class RgisterChangePasswordVisibilityState extends RegisterStates {}
