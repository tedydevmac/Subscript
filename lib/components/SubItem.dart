import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:subscript/Subscription.dart';
import 'package:subscript/main.dart';

class SubItem extends StatelessWidget {
  final Subscription subscribe;
  const SubItem({super.key, required this.subscribe});

  @override
  Widget build(BuildContext context) {
    final navigator = Navigator.of(context);
    final theme = Theme.of(context);
    final formattedDate = DateFormat("dd/MM/yyyy").format(subscribe.dueDate);
    return InkWell(
      onTap: () { /* show editing page */},
      child: ChangeNotifierProvider.value(
        value: subscribe,
        child: Consumer<Subscription>(
          builder: (context, value, child) {
            return Padding(
              padding: EdgeInsets.all(20),
              child: Row(
                children: [
                  Expanded(child: ListTile(title: Text(subscribe.title),subtitle: null,),)
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
