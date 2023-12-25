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
        time: DateTime.now())
  ];

  @override
  Widget build(BuildContext context) => Scaffold(
        body: ExpenseList(expenses: _registeredExpenses),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: const Icon(Icons.add_rounded),
        ),
      );
}
