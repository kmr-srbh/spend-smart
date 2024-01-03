import 'package:flutter/material.dart';

import 'package:hive_flutter/adapters.dart';

import 'package:spend_smart/models/expense.dart';

import 'package:spend_smart/widgets/add_expense_form.dart';
import 'package:spend_smart/widgets/expense_list.dart';

Box expenseBox = Hive.box('expenses');

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) => ValueListenableBuilder(
        valueListenable: expenseBox.listenable(),
        builder: (context, value, child) => Scaffold(
          appBar: AppBar(),
          body: expenseBox.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/bonbon-brown-bear.png',
                        width: 240,
                      ),
                      const SizedBox(height: 48),
                      const Text(
                        'No expenses',
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                )
              : Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(24),
                      child: ValueListenableBuilder(
                        valueListenable: expenseBox.listenable(),
                        builder: (context, value, child) => Text(
                          '₹ ${List<Expense>.from(value.values.toList()).fold(0, (previousValue, element) => previousValue + element.amount)}',
                          style: const TextStyle(
                            fontSize: 48,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: ExpenseList(
                        onExpenseDeleted: () {
                          ScaffoldMessenger.of(context).clearSnackBars();
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Expense deleted.'),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
          floatingActionButton: FloatingActionButton.extended(
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
        ),
      );
}
