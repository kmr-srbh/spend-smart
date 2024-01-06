import 'package:flutter/material.dart';

import 'package:hive_flutter/adapters.dart';

import 'package:spend_smart/widgets/data_manager.dart';
import 'package:spend_smart/widgets/PastExpenses/past_expense_card.dart';

class PastExpensesList extends StatelessWidget {
  PastExpensesList({super.key, required this.expensesData});

  final List<Map<String, dynamic>> expensesData;
  final DataManager dataManager = DataManager();

  @override
  Widget build(BuildContext context) => ValueListenableBuilder(
        valueListenable: dataManager.expenseBox.listenable(),
        builder: (context, value, child) => ListView.builder(
          itemCount: expensesData.length,
          itemBuilder: (context, index) =>
              PastExpenseCard(expenseData: expensesData[index]),
        ),
      );
}
