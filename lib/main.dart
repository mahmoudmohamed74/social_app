// ignore_for_file: use_key_in_widget_constructors, deprecated_member_use

import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:social_app/moduels/login/login_screen.dart';
import 'package:social_app/shared/bloc_observer.dart';

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
      runApp(MyApp());
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginScreen(),
    );
  }
}
