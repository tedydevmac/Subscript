import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

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
    final newDueDate = await DatePicker.showDateTimePicker(
      context,
      showTitleActions: true,
      onChanged: (date) => date,
      onConfirm: (date) {},
    );
    if (newDueDate != null) {
      dueDate = newDueDate;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final mediaQuery = MediaQuery.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final formattedDate =
        dueDate != null ? DateFormat("dd/MM/yyyy").format(dueDate!) : "";
    return Container(
      height: 250,
      margin: EdgeInsets.only(
          bottom: mediaQuery.viewInsets.bottom > 0
              ? mediaQuery.viewInsets.bottom
              : mediaQuery.viewPadding.bottom),
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            decoration: InputDecoration(hintText: "Enter title"),
            controller: titleController,
          ),
          TextField(
              decoration:
                  InputDecoration(hintText: "Enter description (if any)"),
              controller: titleController),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              dueDate == null
                  ? IconButton(
                      onPressed: pickDate,
                      icon: const Icon(Icons.event_available_outlined),
                    )
                  : ActionChip(
                      label: Text(formattedDate),
                      onPressed: pickDate,
                      backgroundColor:
                          isDark ? Colors.grey[700] : Colors.grey[300]),
            ],
          )
        ],
      ),
    );
  }
}
