import 'package:flutter/material.dart';

class OverviewExpenseCard extends StatelessWidget {
  const OverviewExpenseCard({super.key, required this.expensesData});

  final Map<String, dynamic> expensesData;

  String get formattedDate =>
      '${expensesData['date'].day.toString().padLeft(2, '0')}-${expensesData['date'].month.toString().padLeft(2, '0')}-${expensesData['date'].year}';

  @override
  Widget build(BuildContext context) => Card(
        margin: const EdgeInsets.fromLTRB(12, 12, 12, 0),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Text(
                '$formattedDate (${expensesData["totalTransactions"]})',
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              Text(
                '₹ ${expensesData['totalAmount']}',
              )
            ],
          ),
        ),
      );
}
