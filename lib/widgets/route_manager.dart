import 'package:flutter/material.dart';

import 'package:spend_smart/widgets/Overview/overview.dart';
import 'package:spend_smart/widgets/Today/today.dart';
import 'package:spend_smart/widgets/add_expense_form.dart';

class RouteManager extends StatefulWidget {
  const RouteManager({super.key});

  @override
  State<RouteManager> createState() => _RouteManagerState();
}

class _RouteManagerState extends State<RouteManager> {
  late FloatingActionButton addExpense;
  int routeIndex = 0;
  final List<Widget> routes = [TodayExpenses(), Overview()];

  @override
  void initState() {
    super.initState();
    addExpense = FloatingActionButton(
      child: const Icon(Icons.add_rounded),
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
