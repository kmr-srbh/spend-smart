import 'package:flutter/material.dart';
import 'package:spend_smart/widgets/expense.dart';

class ExpenseList extends StatelessWidget {
  const ExpenseList({super.key, required this.expenses});

  final List<Expense> expenses;

  @override
  Widget build(BuildContext context) => ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (buildContext, index) => expenses[index]);
}
