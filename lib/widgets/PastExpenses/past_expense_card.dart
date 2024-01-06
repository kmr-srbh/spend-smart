import 'package:flutter/material.dart';

class PastExpenseCard extends StatelessWidget {
  const PastExpenseCard({super.key, required this.expenseData});

  final Map<String, dynamic> expenseData;

  @override
  Widget build(BuildContext context) => Card(
        margin: const EdgeInsets.fromLTRB(12, 12, 12, 0),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Text(
                '${expenseData["date"]} (${expenseData["totalTransactions"]})',
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              Text(
                '₹ ${expenseData['totalAmount']}',
              )
            ],
          ),
        ),
      );
}
