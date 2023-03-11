import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class AddSubBottomSheet extends StatefulWidget {
  const AddSubBottomSheet({super.key});

  @override
  State<AddSubBottomSheet> createState() => _AddSubBottomSheetState();
}

class _AddSubBottomSheetState extends State<AddSubBottomSheet> {
  
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  DateTime? dueDate;

  Future<void> pickDate() async {
    final newDueDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(3000, 1, 1),
    );
    if (newDueDate != null) {
      dueDate = newDueDate;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}