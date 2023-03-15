import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:subscript/main.dart';

class AddSubBottomSheet extends StatefulWidget {
  const AddSubBottomSheet({super.key});

  @override
  State<AddSubBottomSheet> createState() => _AddSubBottomSheetState();
}

class _AddSubBottomSheetState extends State<AddSubBottomSheet> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final moneyController = TextEditingController();
  var currencyDropdownValue = "None selected";
  var freqDropdownValue = "None selected";
  late String currency;
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

  void firstDropdownCallback(String? selectedValue) {
    if (selectedValue != null) {
      setState(() {
        currencyDropdownValue = selectedValue;
      });
    }
  }

  void secondDropdownCallback(String? selectedValue) {
    if (selectedValue != null) {
      setState(() {
        freqDropdownValue = selectedValue;
      });
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
      height: 320,
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
              controller: descriptionController),
          TextField(
            decoration: InputDecoration(hintText: "Enter price"),
            controller: moneyController,
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              dueDate == null
                  ? IconButton(
                      onPressed: pickDate,
                      iconSize: 26,
                      icon: const Icon(Icons.event_available_outlined),
                    )
                  : ActionChip(
                      label: Text(formattedDate),
                      onPressed: pickDate,
                      backgroundColor: isDark
                          ? Colors.grey[800]
                          : Color.fromRGBO(246, 242, 249, 1),
                      elevation: 0,
                    ),
              const SizedBox(
                width: 10,
              ),
              SizedBox(
                width: 128.5,
                child: DropdownButton(
                  items: const [
                    DropdownMenuItem(
                        child: Text("Select currency"), value: "None selected"),
                    DropdownMenuItem(child: Text("SGD"), value: "SGD"),
                    DropdownMenuItem(child: Text("USD"), value: "USD"),
                    DropdownMenuItem(child: Text("EUR"), value: "EUR"),
                    DropdownMenuItem(child: Text("JPY"), value: "JPY"),
                    DropdownMenuItem(child: Text("GBP"), value: "GBP"),
                    DropdownMenuItem(child: Text("CAD"), value: "CAD"),
                    DropdownMenuItem(child: Text("AUD"), value: "AUD"),
                    DropdownMenuItem(child: Text("CHF"), value: "CHF"),
                    DropdownMenuItem(child: Text("CNY"), value: "CNY"),
                    DropdownMenuItem(child: Text("HKD"), value: "HKD"),
                    DropdownMenuItem(child: Text("NZD"), value: "NZD"),
                  ],
                  value: currencyDropdownValue,
                  onChanged: firstDropdownCallback,
                  isExpanded: true,
                  icon: const Icon(Icons.attach_money),
                  iconSize: 25,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              SizedBox(
                width: 128.5,
                child: DropdownButton(
                  items: const [
                    DropdownMenuItem(
                        child: Text("Select frequency"),
                        value: "None selected"),
                    DropdownMenuItem(child: Text("Daily"), value: "per day"),
                    DropdownMenuItem(child: Text("Weekly"), value: "per week"),
                    DropdownMenuItem(
                        child: Text("Monthly"), value: "per month"),
                    DropdownMenuItem(child: Text("Yearly"), value: "per year"),
                  ],
                  value: freqDropdownValue,
                  onChanged: secondDropdownCallback,
                  isExpanded: true,
                  icon: Icon(Icons.schedule),
                  iconSize: 25,
                ),
              )
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                onPressed: () {},
                style: filledButtonStyle,
                child: Text("Add subscription"),
              )
            ],
          )
        ],
      ),
    );
  }
}
