import 'package:flutter/material.dart';

import 'package:hive/hive.dart';

import 'package:spend_smart/models/expense.dart';

class DataManager {
  final Box expenseBox = Hive.box('expenses');

  String get boxKey {
    DateTime today = DateTime.now();
    String key = '${today.day}-${today.month}-${today.year}';
    if (!expenseBox.containsKey(key)) expenseBox.put(key, null);
    return key;
  }

  double toDouble(TimeOfDay time) => time.hour + time.minute / 60.0;

  List<Expense> get expenses {
    List<Expense> expenses = List<Expense>.from(expenseBox.get(boxKey));
    return expenses;
  }

  List<Expense> sort(List<Expense> expenses) {
    expenses.sort(
      (firstExpense, secondExpense) =>
          toDouble(secondExpense.time).compareTo(toDouble(firstExpense.time)),
    );
    return expenses;
  }

  void add(Expense expense) async {
    List<Expense> newExpenseList = expenses;
    newExpenseList.add(expense);
    newExpenseList = sort(newExpenseList);
    await expenseBox.put(boxKey, newExpenseList);
  }

  void remove(Expense expense) async {
    List<Expense> newExpenseList = expenses;
    newExpenseList.remove(expense);
    newExpenseList = sort(newExpenseList);
    await expenseBox.put(boxKey, newExpenseList);
  }
}
