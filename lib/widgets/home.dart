import 'package:flutter/material.dart';

import 'package:spend_smart/widgets/expense.dart';
import 'package:spend_smart/widgets/expense_list.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<StatefulWidget> createState() => _Home();
}

class _Home extends State<Home> {
  final List<Expense> _registeredExpenses = [
    Expense(
      title: 'Flutter Course',
      amount: 389,
      date: DateTime.now(),
      time: DateTime.now(),
      category: Category.work,
    ),
    Expense(
      title: 'Samosa x2',
      amount: 14,
      date: DateTime.now(),
      time: DateTime.now(),
      category: Category.food,
    ),
    Expense(
      title: 'Metro fare',
      amount: 15,
      date: DateTime.now(),
      time: DateTime.now(),
      category: Category.travel,
    ),
    Expense(
      title: 'Flutter Course',
      amount: 389,
      date: DateTime.now(),
      time: DateTime.now(),
      category: Category.work,
    ),
    Expense(
      title: 'Samosa x2',
      amount: 14,
      date: DateTime.now(),
      time: DateTime.now(),
      category: Category.food,
    ),
    Expense(
      title: 'Metro fare',
      amount: 15,
      date: DateTime.now(),
      time: DateTime.now(),
      category: Category.travel,
    )
  ];

  int get amountSpent {
    int totalAmount = 0;
    for (Expense expense in _registeredExpenses) {
      totalAmount += expense.amount;
    }
    return totalAmount;
  }

  void _showInputDialog() {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Add expense'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Name',
                errorText: null,
              ),
            ),
            const SizedBox(height: 16),
            const TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Amount',
                errorText: null,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                const Icon(Icons.calendar_month_rounded),
                TextButton(
                  onPressed: () {},
                  child: const Text('Date'),
                ),
                const Spacer(),
                const Icon(Icons.access_time_rounded),
                TextButton(
                  onPressed: () {},
                  child: const Text('Time'),
                ),
              ],
            ),
            const SizedBox(height: 48),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel'),
                ),
                const SizedBox(width: 16),
                ElevatedButton(
                  onPressed: () {}, // TODO: Add functionality to add expenses
                  child: const Text('Add'),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(scrolledUnderElevation: 0),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 24),
              child: Text(
                '₹ ${amountSpent.toString()}',
                style:
                    const TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(child: ExpenseList(expenses: _registeredExpenses)),
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: _showInputDialog,
          label: const Text('Add expense'),
          icon: const Icon(Icons.add_rounded),
        ),
      );
}
