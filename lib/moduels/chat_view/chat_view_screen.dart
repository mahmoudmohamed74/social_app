// ignore_for_file: must_be_immutable, use_key_in_widget_constructors, prefer_const_constructors, sized_box_for_whitespace

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/cubit/cubit.dart';
import 'package:social_app/cubit/states.dart';
import 'package:social_app/models/message_model.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/shared/styles/themes/colors.dart';
import 'package:social_app/shared/styles/themes/icon_broken.dart';

class ChatViewScreen extends StatelessWidget {
  UserModel? userModel;

  ChatViewScreen({
    this.userModel,
  });

  var messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (BuildContext context) {
        SocialCubit.get(context).getMessages(
          receiverId: '${userModel!.uId}',
        );
        return BlocConsumer<SocialCubit, SocialState>(
          listener: (context, state) {},
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    IconBroken.Arrow___Left_2,
                  ),
                ),
                titleSpacing: 0.0,
                title: Row(
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundImage: NetworkImage('${userModel!.image}'),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Text('${userModel!.name}'),
                  ],
                ),
              ),
              body: ConditionalBuilder(
                condition: SocialCubit.get(context).messages.isNotEmpty,
                builder: (context) => Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.separated(
                          physics: BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            var message =
                                SocialCubit.get(context).messages[index];

                            if (SocialCubit.get(context).userModel!.uId ==
                                message.senderId) {
                              return buildMyMess(message);
                            }
                            return buildMess(message);
                          },
                          separatorBuilder: (context, index) => SizedBox(
                            height: 15,
                          ),
                          itemCount: SocialCubit.get(context).messages.length,
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 50,
                              child: TextFormField(
                                controller: messageController,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(40),
                                  ),
                                  hintText: 'Message',
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          InkWell(
                            onTap: () {
                              SocialCubit.get(context).sendMessage(
                                receiverId: '${userModel!.uId}',
                                dateTime: '${DateTime.now()}',
                                text: messageController.text,
                              );
                            },
                            child: CircleAvatar(
                              backgroundColor: defaultColor,
                              radius: 25,
                              child: Icon(
                                IconBroken.Send,
                                size: 28,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                fallback: (context) => Center(
                  child: Text('No Message Yet'),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget buildMess(MessageModel model) => Align(
        alignment: AlignmentDirectional.centerStart,
        child: Container(
          decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadiusDirectional.only(
                bottomEnd: Radius.circular(10),
                topStart: Radius.circular(10),
                topEnd: Radius.circular(10),
              )),
          padding: EdgeInsets.symmetric(
            vertical: 5,
            horizontal: 10,
          ),
          child: Text(
            '${model.text}',
          ),
        ),
      );

  Widget buildMyMess(MessageModel model) => Align(
        alignment: AlignmentDirectional.centerEnd,
        child: Container(
          decoration: BoxDecoration(
              color: defaultColor.withOpacity(.5),
              borderRadius: BorderRadiusDirectional.only(
                bottomStart: Radius.circular(10),
                topStart: Radius.circular(10),
                topEnd: Radius.circular(10),
              )),
          padding: EdgeInsets.symmetric(
            vertical: 5,
            horizontal: 10,
          ),
          child: Text(
            '${model.text}',
          ),
        ),
      );
}
