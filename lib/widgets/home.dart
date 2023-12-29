import 'package:flutter/material.dart';

import 'package:spend_smart/models/expense.dart';

import 'package:spend_smart/widgets/add_expense.dart';
import 'package:spend_smart/widgets/expense_list.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<StatefulWidget> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<Expense> _registeredExpenses = [];

  int get _amountSpent {
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
        content: SingleChildScrollView(
          child: AddExpense(onExpenseAdded: _addExpense),
        ),
      ),
    );
  }

  void _addExpense(Expense expense) {
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  void _removeExpense(Expense expense) {
    final int expenseIndex = _registeredExpenses.indexOf(expense);

    setState(() {
      _registeredExpenses.remove(expense);
    });

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 5),
        content: const Text('Expense deleted.'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              _registeredExpenses.insert(expenseIndex, expense);
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.info_outline_rounded),
            )
          ],
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(24),
              child: Text(
                '₹ ${_amountSpent.toString()}',
                style: const TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              child: ExpenseList(
                expenses: _registeredExpenses,
                removeExpense: _removeExpense,
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: _showInputDialog,
          label: const Text('Add expense'),
          icon: const Icon(Icons.add_rounded),
        ),
        bottomNavigationBar: NavigationBar(
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.today_outlined),
              selectedIcon: Icon(Icons.today_rounded),
              label: "Today's Expenses",
            ),
            NavigationDestination(
              icon: Icon(Icons.date_range_outlined),
              selectedIcon: Icon(Icons.date_range_rounded),
              label: 'Past Expenses',
            ),
          ],
        ),
      );
}
