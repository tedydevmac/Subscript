import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:subscript/services/notificationservice.dart';
import 'package:subscript/pages/homepage.dart';
import 'dart:async';
import 'package:subscript/services/subscription.dart';
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
final List<Subscription> Subscripts = [
  Subscription(
      title: "Netflix",
      description: null,
      dueDate: DateTime(2022, 1, 1),
      price: 5.12,
      frequency: "per month"),
  Subscription(
      title: "Youtube Premium",
      description: null,
      dueDate: DateTime(2023, 3, 11, 23, 19),
      price: 90,
      frequency: "per year")
];

late final NotificationService notificationService;

/// Feedback:
/// 1. Use notificationService globally and initialize in main function

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  notificationService = await NotificationService.initNotification();

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
