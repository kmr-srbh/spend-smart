import 'package:flutter/material.dart';

import 'package:spend_smart/widgets/data_manager.dart';
import 'package:spend_smart/widgets/AllExpenses/all_expense_card.dart';

class AllExpensesList extends StatelessWidget {
  AllExpensesList({super.key, required this.expensesData});

  final List<Map<String, dynamic>> expensesData;
  final DataManager dataManager = DataManager();

  @override
  Widget build(BuildContext context) => ListView.builder(
        itemCount: expensesData.length,
        itemBuilder: (context, index) =>
            AllExpenseCard(expenseData: expensesData[index]),
      );
}
