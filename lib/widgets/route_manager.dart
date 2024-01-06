import 'package:flutter/material.dart';

import 'package:spend_smart/widgets/past_expenses.dart';
import 'package:spend_smart/widgets/today_expenses.dart';

class RouteManager extends StatefulWidget {
  const RouteManager({super.key});

  @override
  State<RouteManager> createState() => _RouteManagerState();
}

class _RouteManagerState extends State<RouteManager> {
  int routeIndex = 0;
  final List<Widget> routes = [TodayExpenses(), const PastExpenses()];

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(),
        body: routes[routeIndex],
        bottomNavigationBar: NavigationBar(
          destinations: const [
            NavigationDestination(
                icon: Icon(Icons.receipt_outlined),
                selectedIcon: Icon(Icons.receipt_rounded),
                label: "Today's Expenses"),
            NavigationDestination(
                icon: Icon(Icons.receipt_long_outlined),
                selectedIcon: Icon(Icons.receipt_long),
                label: "Past Expenses"),
          ],
          selectedIndex: routeIndex,
          onDestinationSelected: (value) => setState(() {
            routeIndex = value;
          }),
        ),
      );
}
