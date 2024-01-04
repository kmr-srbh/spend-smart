import 'package:flutter/material.dart';

class PastExpenses extends StatefulWidget {
  const PastExpenses({super.key});
  
  @override
  State<StatefulWidget> createState() => _PastExpensesState();
}

class _PastExpensesState extends State<PastExpenses> {
  @override
  Widget build(BuildContext context) => const Center(
        child: Text('Past Expenses'),
      );
}
