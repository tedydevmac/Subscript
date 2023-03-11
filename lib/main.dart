import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:subscript/pages/homepage.dart';
import 'dart:async';
import 'package:subscript/Subscription.dart';
import 'package:subscript/pages/signinpage.dart';

final lightTheme = ThemeData.light(useMaterial3: true);
final filledButtonStyle = ElevatedButton.styleFrom(
        backgroundColor: lightTheme.colorScheme.primary,
        foregroundColor: lightTheme.colorScheme.onPrimary)
    .copyWith(elevation: MaterialStateProperty.resolveWith((states) {
  if (states.contains(MaterialState.hovered)) {
    return 1;
  }
  return 0;
}));

final darkTheme = ThemeData.dark(useMaterial3: true);
final darkFilledButtonStyle = ElevatedButton.styleFrom(
        backgroundColor: darkTheme.colorScheme.primary,
        foregroundColor: darkTheme.colorScheme.onPrimary)
    .copyWith(elevation: MaterialStateProperty.resolveWith((states) {
  if (states.contains(MaterialState.hovered)) {
    return 1;
  }
  return 0;
}));

late final String uid;
final List<Subscription> Subscripts = [];

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  final currentUser = FirebaseAuth.instance.currentUser;
  if (currentUser == null) {
    runApp(MaterialApp(
      theme: lightTheme,
      darkTheme: darkTheme,
      home: const SignInPage(),
    ));
  } else {
    uid = currentUser.uid;
    runApp(MaterialApp(
      theme: lightTheme,
      darkTheme: darkTheme,
      home: const HomePage(),
    ));
  }
}
