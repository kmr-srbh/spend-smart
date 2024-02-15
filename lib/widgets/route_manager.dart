import 'package:flutter/material.dart';
import 'package:spend_smart/settings.dart';

import 'package:spend_smart/widgets/Overview/overview.dart';
import 'package:spend_smart/widgets/Today/today.dart';
import 'package:spend_smart/widgets/add_expense_form.dart';

class RouteManager extends StatefulWidget {
  const RouteManager({super.key});

  @override
  State<RouteManager> createState() => _RouteManagerState();
}

class _RouteManagerState extends State<RouteManager> {
  int routeIndex = 0;
  final List<Widget> routes = [TodayExpenses(), Overview()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Spend Smart'),
        centerTitle: true,
        actions: [
          IconButton(
              icon: const Icon(Icons.search_rounded),
              onPressed: () {
                showSearch(
                    context: context, delegate: ExpensesSearchDelegate());
              }),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              leading: const Icon(Icons.settings_outlined),
              title: const Text('Settings'),
              subtitle: const Text('Spend limit, etc.'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Settings()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.info_outline_rounded),
              title: const Text('About'),
              onTap: () {},
            ),
          ],
        ),
      ),
      body: routes[routeIndex],
      floatingActionButton: FloatingActionButton.extended(
        label: const Text('Add Expense'),
        icon: const Icon(Icons.add_rounded),
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
      ),
      bottomNavigationBar: NavigationBar(
        destinations: const [
          NavigationDestination(
              icon: Icon(Icons.account_balance_wallet_outlined),
              selectedIcon: Icon(Icons.account_balance_wallet_rounded),
              label: 'Today'),
          NavigationDestination(
              icon: Icon(Icons.insert_chart_outlined_rounded),
              selectedIcon: Icon(Icons.insert_chart_rounded),
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

class ExpensesSearchDelegate extends SearchDelegate {
  @override
  Widget? buildLeading(BuildContext context) => IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: const Icon(Icons.arrow_back_rounded),
      );

  @override
  List<Widget>? buildActions(BuildContext context) => [
        IconButton(
          onPressed: () {
            if (query.isEmpty) {
              close(context, null);
            } else {
              query = '';
            }
          },
          icon: const Icon(Icons.clear_rounded),
        ),
      ];

  @override
  Widget buildResults(BuildContext context) => Text('Value');

  @override
  Widget buildSuggestions(BuildContext context) => Text('Value');
}
