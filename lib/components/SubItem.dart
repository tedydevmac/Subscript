import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:subscript/Subscription.dart';
import 'package:subscript/main.dart';

/* 
things to include:
  late String _title;               #
  late DateTime _dueDate;
  late double _price;               #
  late final String _freq;          #
*/

class SubItem extends StatelessWidget {
  final Subscription subscribe;
  const SubItem({super.key, required this.subscribe});

  @override
  Widget build(BuildContext context) {
    final navigator = Navigator.of(context);
    final theme = Theme.of(context);
    final formattedDate = DateFormat("dd/MM/yyyy").format(subscribe.dueDate);
    final formattedPrice = NumberFormat.currency(symbol: '\$', decimalDigits: 2)
        .format(subscribe.price);
    return InkWell(
      onTap: () {/* show editing page */},
      child: ChangeNotifierProvider.value(
        value: subscribe,
        child: Consumer<Subscription>(
          builder: (context, value, child) {
            return Padding(
              padding: EdgeInsets.all(20),
              child: Row(
                children: [
                  Expanded(
                    child: ListTile(
                      title: Text(subscribe.title),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text("${formattedPrice} "),
                              Text(subscribe.freq),
                            ],
                          ),
                          Chip(label: Text(formattedDate))
                        ],
                      ),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {},
                        style: filledButtonStyle,
                        child: Text("Add reminder"),
                      ),
                    ],
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
