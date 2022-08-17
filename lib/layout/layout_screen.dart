// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/cubit/cubit.dart';
import 'package:social_app/cubit/states.dart';
import 'package:social_app/moduels/login/login_screen.dart';
import 'package:social_app/shared/components/components/components.dart';

class LayoutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text("News Feed"),
              actions: [
                IconButton(
                  onPressed: () {
                    navigateAndFinish(
                      context,
                      LoginScreen(),
                    );
                  },
                  icon: Icon(
                    Icons.search,
                  ),
                ),
              ],
            ),
            body: ConditionalBuilder(
              condition: SocialCubit.get(context).model != null,
              builder: (context) {
                // var model = SocialCubit.get(context).model;

                return Column(
                  children: [
                    if (!FirebaseAuth.instance.currentUser!.emailVerified)
                      Container(
                        color: Colors.amber.withOpacity(.5),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.info_outline,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Text("Please verify your email"),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              defaultTextButton(
                                function: () {
                                  FirebaseAuth.instance.currentUser!
                                      .sendEmailVerification()
                                      .then((value) {
                                    showToast(
                                      text: "check your mail ",
                                      state: ToastStates.SUCCESS,
                                    );
                                  }).catchError((error) {
                                    showToast(
                                      text: " faild ",
                                      state: ToastStates.ERROR,
                                    );
                                  });
                                },
                                text: "send",
                              ),
                            ],
                          ),
                        ),
                      ),
                  ],
                );
              },
              fallback: (context) => Center(child: CircularProgressIndicator()),
            ),
          );
        });
  }
}
