import 'package:flutter/material.dart';

import 'package:spend_smart/widgets/add_expense_form.dart';
import 'package:spend_smart/widgets/past_expenses.dart';
import 'package:spend_smart/widgets/today_expenses.dart';

class RouteManager extends StatefulWidget {
  const RouteManager({super.key});

  @override
  State<RouteManager> createState() => _RouteManagerState();
}

class _RouteManagerState extends State<RouteManager> {
  int routeIndex = 0;
  final List<Widget> routes = const [TodayExpenses(), PastExpenses()];

  FloatingActionButton? addExpenseFAB;

  @override
  void initState() {
    super.initState();
    addExpenseFAB = FloatingActionButton.extended(
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
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(),
        body: routes[routeIndex],
        floatingActionButton: routeIndex == 0 ? addExpenseFAB : null,
        bottomNavigationBar: NavigationBar(
          destinations: const [
            NavigationDestination(
                icon: Icon(Icons.account_balance_wallet_outlined),
                selectedIcon: Icon(Icons.account_balance_wallet_rounded),
                label: "Today's Expenses"),
            NavigationDestination(
                icon: Icon(Icons.work_history_outlined),
                selectedIcon: Icon(Icons.work_history_rounded),
                label: "Past Expenses"),
          ],
          selectedIndex: routeIndex,
          onDestinationSelected: (value) => setState(() {
            routeIndex = value;
          }),
        ),
      );
}
