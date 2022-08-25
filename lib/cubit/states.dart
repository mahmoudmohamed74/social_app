abstract class SocialState {}

class SocialInitialState extends SocialState {}

class SocialGetUserLoadingState extends SocialState {}

class SocialGetUserSuccessState extends SocialState {}

class SocialGetUserErrorState extends SocialState {
  final String error;

  SocialGetUserErrorState(this.error);
}

//all users

class SocialGetAllUsersLoadingState extends SocialState {}

class SocialGetAllUsersSuccessState extends SocialState {}

class SocialGetAllUsersErrorState extends SocialState {
  final String error;

  SocialGetAllUsersErrorState(this.error);
}

class SocialChangeBottomNavState extends SocialState {}

class SocialNewPostState extends SocialState {}

class SocialProfileImagePickedSuccessState extends SocialState {}

class SocialProfileImagePickedErrorState extends SocialState {}

class SocialCoverImagePickedSuccessState extends SocialState {}

class SocialCoverImagePickedErrorState extends SocialState {}

class SocialUploadProfileImageSuccessState extends SocialState {}

class SocialUploadProfileImageErrorState extends SocialState {}

class SocialUploadCoverImageSuccessState extends SocialState {}

class SocialUploadCoverImageErrorState extends SocialState {}

class SocialUserUpdateLoadingState extends SocialState {}

class SocialUserUpdateErrorState extends SocialState {}

//posts

class SocialCreatePostLoadingState extends SocialState {}

class SocialCreatePostSuccessState extends SocialState {}

class SocialCreatePostErrorState extends SocialState {
  final String error;

  SocialCreatePostErrorState(this.error);
}

class SocialPostImagePickedSuccessState extends SocialState {}

class SocialPostImagePickedErrorState extends SocialState {}

class SocialRemovePostImagePickedSuccessState extends SocialState {}

class SocialGetPostsLoadingState extends SocialState {}

class SocialGetPostsSuccessState extends SocialState {}

class SocialGetPostsErrorState extends SocialState {
  final String error;

  SocialGetPostsErrorState(this.error);
}

class SocialLikePostSuccessState extends SocialState {}

class SocialLikePostErrorState extends SocialState {
  final String error;

  SocialLikePostErrorState(this.error);
}

class SocialCommentPostSuccessState extends SocialState {}

class SocialCommentPostErrorState extends SocialState {
  final String error;

  SocialCommentPostErrorState(this.error);
}
// chats

class SocialSendMessagesSuccessState extends SocialState {}

class SocialSendMessagesErrorState extends SocialState {}

class SocialGetMessagesSuccessState extends SocialState {}

class SocialGetMessagesErrorState extends SocialState {}
