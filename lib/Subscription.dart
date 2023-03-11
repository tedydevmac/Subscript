import 'dart:ffi';
import 'main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Subscription extends ChangeNotifier {
  late final String id;
  late String _title;
  late String? _desc;
  late DateTime _dueDate;
  late Double _price;
  late final String _freq;

  String get title => _title;
  set title(String title) {
    _title = title;
    notifyListeners();
  }

  String? get desc => _desc;
  set desc(String? desc) {
    _desc = desc;
    notifyListeners();
  }

  DateTime get dueDate => _dueDate;
  set dueDate(DateTime dueDate) {
    _dueDate = dueDate;
    notifyListeners();
  }

  Double get price => _price;
  set price(Double price) {
    _price = price;
    notifyListeners();
  }

  String get freq => _freq;
  set freq(String freq) {
    _freq = freq;
    notifyListeners();
  }

  DocumentReference get _firebaseDocReference => FirebaseFirestore.instance
      .collection("accounts")
      .doc(uid)
      .collection("subscriptions")
      .doc(id);
  Map<String, dynamic> get _firebaseDocMap => {
        "id": id,
        "title": _title,
        "description": _desc,
        "dueDate": dueDate.millisecondsSinceEpoch,
        "price": _price
      };

  Subscription(
      {required String id,
      required String title,
      required String? description,
      required DateTime dueDate,
      required Double price}) {
    _title = title;
    _desc = description;
    _dueDate = dueDate;
    _price = price;
  }
  Subscription.initializeFromDocSnapshot(
      {required DocumentSnapshot documentSnapshot}) {
    id = documentSnapshot["id"];
    _title = documentSnapshot["title"];
    _desc = documentSnapshot["description"];
    _dueDate = DateTime.fromMillisecondsSinceEpoch(documentSnapshot["dueDate"]);
    _price = documentSnapshot["price"];
  }

  Future<void> storeSub() async {
    await _firebaseDocReference.set(_firebaseDocMap);
  }

  Future<void> updateSub() async {
    await _firebaseDocReference.update(_firebaseDocMap);
  }

  Future<void> deleteSub() async {
    await _firebaseDocReference.delete();
  }
}
