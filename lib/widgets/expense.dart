import 'package:flutter/material.dart';

class Expense extends StatelessWidget {
  const Expense(
      {super.key,
      required this.title,
      required this.amount,
      required this.date,
      required this.time});

  final String title;
  final int amount;
  final DateTime date;
  final DateTime time;

  String get formattedDate => '${date.day}-${date.month}-${date.year}';
  String get formattedTime => '${time.hour}:${time.minute}';

  @override
  Widget build(BuildContext context) => Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  )),
              const SizedBox(height: 8),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text('₹ ${amount.toString()}'),
                  const Spacer(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(formattedTime),
                      Text(formattedDate),
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      );
}
