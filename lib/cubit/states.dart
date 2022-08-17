abstract class SocialState {}

class SocialInitialState extends SocialState {}

class SocialGetUserLoadingState extends SocialState {}

class SocialGetUserSuccessState extends SocialState {}

class SocialGetUserErrorState extends SocialState {
  final String error;

  SocialGetUserErrorState(this.error);
}
