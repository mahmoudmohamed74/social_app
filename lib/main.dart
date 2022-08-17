// ignore_for_file: use_key_in_widget_constructors, deprecated_member_use, prefer_const_constructors_in_immutables, avoid_print

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/cubit/cubit.dart';
import 'package:social_app/cubit/states.dart';
import 'package:social_app/layout/layout_screen.dart';
import 'package:social_app/moduels/login/login_screen.dart';
import 'package:social_app/shared/bloc_observer.dart';
import 'package:social_app/shared/components/constants/constants.dart';
import 'package:social_app/shared/network/local/cache_helper.dart';
import 'package:social_app/shared/styles/themes/themes.dart';

// import 'firebase_options.dart';
void main() {
  //put run app in runzoned
  BlocOverrides.runZoned(
    () async {
      WidgetsFlutterBinding
          .ensureInitialized(); // used for async & await 7uegy b3dha
      await Firebase.initializeApp(
          // options: DefaultFirebaseOptions.currentPlatform,
          );

      await CacheHelper.init();

      Widget? widget;
      print(uId);
      if (uId != null) {
        widget = LayoutScreen();
      } else {
        widget = LoginScreen();
      }
      runApp(MyApp(
        startWidget: widget,
      ));
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  final Widget? startWidget;
  MyApp({this.startWidget});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SocialCubit()..getUserData(),
      child: BlocConsumer<SocialCubit, SocialState>(
          listener: (context, state) {},
          builder: (context, state) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: lightTheme,
              home: startWidget,
            );
          }),
    );
  }
}
