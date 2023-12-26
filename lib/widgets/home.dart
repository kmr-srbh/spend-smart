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
      builder: (dialogContext) => const AlertDialog(
        title: Text('Add expense'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Name',
                  errorText: null),
            ),
            SizedBox(height: 24),
            TextField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Amount',
                  errorText: null),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(),
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
        floatingActionButton: FloatingActionButton.large(
          onPressed: _showInputDialog,
          child: const Icon(Icons.add_rounded),
        ),
      );
}
