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
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.payments_outlined), text: 'Today'),
              Tab(icon: Icon(Icons.analytics_outlined), text: 'Overview'),
            ],
          ),
        ),
        body: TabBarView(
          children: [TodayExpenses(), Overview()],
        ),
        floatingActionButton: addExpense,
      ),
    );
  }
}
