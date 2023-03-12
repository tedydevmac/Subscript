import 'package:flutter/material.dart';
import 'package:subscript/services/subscription.dart';
import 'package:subscript/components/subitem.dart';
import 'package:subscript/components/add_sub_bottom_sheet.dart';
import 'package:subscript/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    asyncinit();
    super.initState();
  }

  Future<void> asyncinit() async {
    final tasksQuerySnapshot = await FirebaseFirestore.instance
        .collection("accounts")
        .doc(uid)
        .collection("subscriptions")
        .get();
    for (var i = 0; i < tasksQuerySnapshot.docs.length; i++) {
      final eachTasksDoc = tasksQuerySnapshot.docs[i];
      Subscripts.add(Subscription.initializeFromDocSnapshot(
          documentSnapshot: eachTasksDoc));
    }
  }

  void showAddSubBottomSheet() {
    showModalBottomSheet(
        context: context,
        builder: (bottomSheetContext) => const AddSubBottomSheet(),
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(18),
            topRight: Radius.circular(18),
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    final navigator = Navigator.of(context);
    return MaterialApp(
      theme: lightTheme,
      darkTheme: darkTheme,
      home: Scaffold(
        floatingActionButton: FloatingActionButton.extended(
          onPressed: showAddSubBottomSheet,
          label: const Text("Add subscription"),
          icon: const Icon(Icons.add_outlined),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        appBar: AppBar(
          title: Row(
            mainAxisSize: MainAxisSize.min,
            children: [const Text("My Subscriptions")],
          ),
        ),
        body: SafeArea(
          top: false,
          child: ListView(
            children: [
              ListView.separated(
                separatorBuilder: (separatorContext, index) => const Divider(
                  color: Colors.grey,
                  thickness: 0.4,
                  height: 1,
                ),
                itemBuilder: (context, index) {
                  final eachSub = Subscripts[index];
                  return SubItem(subscribe: eachSub);
                },
                itemCount: Subscripts.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
