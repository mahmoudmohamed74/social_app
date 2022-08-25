// ignore_for_file: avoid_print, deprecated_member_use, avoid_function_literals_in_foreach_calls

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/cubit/states.dart';
import 'package:social_app/models/message_model.dart';
import 'package:social_app/models/post_model.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/moduels/chats/chats_screen.dart';
import 'package:social_app/moduels/feeds/feeds_screen.dart';
import 'package:social_app/moduels/new_post/new_post_screen.dart';
import 'package:social_app/moduels/settings/settings_screen.dart';
import 'package:social_app/moduels/users/users_screen.dart';
import 'package:social_app/shared/components/constants/constants.dart';

class SocialCubit extends Cubit<SocialState> {
  SocialCubit() : super(SocialInitialState());
  static SocialCubit get(context) => BlocProvider.of(context);

  UserModel? userModel;

  void getUserData() {
    emit(SocialGetUserLoadingState());
    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
      userModel = UserModel.fromJson(value.data());
      emit(SocialGetUserSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(SocialGetUserErrorState(error.toString()));
    });
  }

  int currentIndex = 0;
  List<Widget> screens = [
    FeedsScreen(),
    ChatsScreen(),
    NewPostScreen(),
    UsersScreen(),
    SettingsScreen(),
  ];

  List<String> titles = [
    'Home',
    'Chats',
    'POSTS',
    'Users',
    'Settings',
  ];
  void changeBottomNav(int index) {
    if (index == 1) {
      getAllUsers();
    }
    if (index == 2) {
      emit(SocialNewPostState());
    } else {
      currentIndex = index;
      emit(SocialChangeBottomNavState());
    }
  }

  File? profileImage;
  var picker = ImagePicker();

  Future<void> getProfileImage() async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      emit(SocialProfileImagePickedSuccessState());
    } else {
      print('No image selected.');
      emit(SocialProfileImagePickedErrorState());
    }
  }

  File? coverImage;

  Future<void> getCoverImage() async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      coverImage = File(pickedFile.path);
      emit(SocialCoverImagePickedSuccessState());
    } else {
      print('No image selected.');
      emit(SocialCoverImagePickedErrorState());
    }
  }

  void uploadProfileImage({
    required String name,
    required String phone,
    required String bio,
  }) {
    emit(SocialUserUpdateLoadingState());

    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        //emit(SocialUploadProfileImageSuccessState());
        print(value);
        updateUserData(
          name: name,
          phone: phone,
          bio: bio,
          image: value,
        );
      }).catchError((error) {
        emit(SocialUploadProfileImageErrorState());
      });
    }).catchError((error) {
      emit(SocialUploadProfileImageErrorState());
    });
  }

  void uploadCoverImage({
    required String name,
    required String phone,
    required String bio,
  }) {
    emit(SocialUserUpdateLoadingState());

    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(coverImage!.path).pathSegments.last}')
        .putFile(coverImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        //emit(SocialUploadCoverImageSuccessState());
        print(value);
        updateUserData(
          name: name,
          phone: phone,
          bio: bio,
          cover: value,
        );
      }).catchError((error) {
        emit(SocialUploadCoverImageErrorState());
      });
    }).catchError((error) {
      emit(SocialUploadCoverImageErrorState());
    });
  }

  void updateUserData({
    required String name,
    required String phone,
    required String bio,
    String? cover,
    String? image,
  }) {
    UserModel model = UserModel(
      uId: userModel!.uId,
      email: userModel!.email,
      name: name,
      phone: phone,
      bio: bio,
      image: image ?? userModel!.image,
      cover: cover ?? userModel!.cover,
      isEmailVerified: false,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .update(model.toMap())
        .then((value) {
      getUserData();
    }).catchError((error) {
      emit(SocialUserUpdateErrorState());
    });
  }

// post

  File? postImage;

  Future<void> getPostImage() async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      postImage = File(pickedFile.path);
      emit(SocialPostImagePickedSuccessState());
    } else {
      print('No image selected.');
      emit(SocialPostImagePickedErrorState());
    }
  }

  void removePostImage() {
    postImage = null;
    emit(SocialRemovePostImagePickedSuccessState());
  }

  void uploadPostImage({
    required String dateTime,
    required String text,
  }) {
    emit(SocialCreatePostLoadingState());

    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('posts/${Uri.file(postImage!.path).pathSegments.last}')
        .putFile(postImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        //emit(SocialUploadCoverImageSuccessState());
        print(value);
        createPost(
          dateTime: dateTime,
          text: text,
          postImage: value,
        );
      }).catchError((error) {
        print(error.toString());
        emit(SocialCreatePostErrorState(error.toString()));
      });
    }).catchError((error) {
      print(error.toString());
      emit(SocialCreatePostErrorState(error.toString()));
    });
  }

  void createPost({
    required String dateTime,
    required String text,
    String? postImage,
  }) {
    emit(SocialCreatePostLoadingState());

    PostModel model = PostModel(
      name: userModel!.name,
      image: userModel!.image,
      uId: userModel!.uId,
      dateTime: dateTime,
      postImage: postImage ?? "",
      text: text,
    );
    FirebaseFirestore.instance
        .collection('posts')
        .add(model.toMap())
        .then((value) {
      emit(SocialCreatePostSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(SocialCreatePostErrorState(error.toString()));
    });
  }

  List<PostModel> posts = [];
  List<String> postsId = [];
  List<int> likes = [];
  List<int> comments = [];

  void getPosts() {
    FirebaseFirestore.instance.collection("posts").get().then((value) {
      value.docs.forEach((element) {
        element.reference.collection("likes").get().then((value) {
          likes.add(value.docs.length); // طول ليست اللايكس عددهم
          // postsId.add(element.id);
          // posts.add(PostModel.fromJson(element.data()));
        }).catchError((error) {});
      });
      value.docs.forEach(
        (element) {
          element.reference.collection("comments").get().then((value) {
            comments.add(value.docs.length); // طول ليست اللايكس عددهم
            postsId.add(element.id);
            posts.add(PostModel.fromJson(element.data()));
          }).catchError((error) {});
        },
      );

      emit(SocialGetPostsSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(SocialGetPostsErrorState(error.toString()));
    });
  }

  void likePost(String postId) {
    FirebaseFirestore.instance
        .collection("posts")
        .doc(postId)
        .collection("likes")
        .doc(userModel!.uId)
        .set({
      "like": true,
    }).then((value) {
      emit(SocialLikePostSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(SocialLikePostErrorState(error.toString()));
    });
  }

  void commentPost(String postId) {
    FirebaseFirestore.instance
        .collection("posts")
        .doc(postId)
        .collection("comments")
        .doc(userModel!.uId)
        .set({
      "comment": true,
    }).then((value) {
      emit(SocialCommentPostSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(SocialCommentPostErrorState(error.toString()));
    });
  }

  List<UserModel> users = [];

  void getAllUsers() {
    if (users.isEmpty) {
      FirebaseFirestore.instance.collection('users').get().then((value) {
        value.docs.forEach((element) {
          if (element.data()['uId'] != userModel!.uId) {
            users.add(UserModel.fromJson(element.data()));
          }
        });

        emit(SocialGetAllUsersSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(SocialGetAllUsersErrorState(error.toString()));
      });
    }
  }

  void sendMessage({
    required String receiverId,
    required String dateTime,
    required String text,
  }) {
    MessageModel model = MessageModel(
      text: text,
      senderId: userModel!.uId,
      receiverId: receiverId,
      dateTime: dateTime,
    );

    //sender
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .collection("chats")
        .doc(receiverId)
        .collection("messages")
        .add(model.toMap())
        .then((value) {
      emit(SocialSendMessagesSuccessState());
    }).catchError((error) {
      emit(SocialSendMessagesErrorState());
    });

    //receiver
    FirebaseFirestore.instance
        .collection('users')
        .doc(receiverId)
        .collection("chats")
        .doc(userModel!.uId)
        .collection("messages")
        .add(model.toMap())
        .then((value) {
      emit(SocialSendMessagesSuccessState());
    }).catchError((error) {
      emit(SocialSendMessagesErrorState());
    });
  }

  List<MessageModel> messages = [];

  void getMessages({
    required String receiverId,
  }) {
    FirebaseFirestore.instance
        .collection("users")
        .doc(userModel!.uId)
        .collection("chats")
        .doc(receiverId)
        .collection("messages")
        .orderBy("dateTime")
        .snapshots()
        .listen(
      (event) {
        messages = [];
        event.docs.forEach(
          (element) {
            messages.add(MessageModel.fromJson(element.data()));
          },
        );
      },
    );
    emit(SocialGetMessagesSuccessState());
  }
}
