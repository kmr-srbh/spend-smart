import 'package:flutter/material.dart';

import 'package:spend_smart/widgets/AllExpenses/all_expenses.dart';
import 'package:spend_smart/widgets/TodayExpenses/today_expenses.dart';
import 'package:spend_smart/widgets/add_expense_form.dart';

class RouteManager extends StatefulWidget {
  const RouteManager({super.key});

  @override
  State<RouteManager> createState() => _RouteManagerState();
}

class _RouteManagerState extends State<RouteManager> {
  late FloatingActionButton addExpense;
  int routeIndex = 0;
  final List<Widget> routes = [TodayExpenses(), AllExpenses()];

  @override
  void initState() {
    super.initState();
    addExpense = FloatingActionButton.extended(
      onPressed: () {
        showDialog(
          context: context,
          builder: (dialogContext) => const AlertDialog(
            title: Text('Add expense'),
            content: SingleChildScrollView(
              child: AddExpenseForm(),
            ),
          ),
        );
      },
      label: const Text('Add expense'),
      icon: const Icon(Icons.add_rounded),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: routes[routeIndex],
      floatingActionButton: routeIndex == 0 ? addExpense : null,
      bottomNavigationBar: NavigationBar(
        destinations: const [
          NavigationDestination(
              icon: Icon(Icons.receipt_outlined),
              selectedIcon: Icon(Icons.receipt_rounded),
              label: 'Today'),
          NavigationDestination(
              icon: Icon(Icons.receipt_long_outlined),
              selectedIcon: Icon(Icons.receipt_long),
              label: 'Overview'),
        ],
        selectedIndex: routeIndex,
        onDestinationSelected: (value) => setState(() {
          routeIndex = value;
        }),
      ),
    );
  }
}
