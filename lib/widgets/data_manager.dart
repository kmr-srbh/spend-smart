import 'package:flutter/material.dart';

import 'package:hive/hive.dart';

import 'package:spend_smart/models/expense.dart';

class DataManager {
  final Box expenseBox = Hive.box('expenses');

  double toDouble(TimeOfDay time) => time.hour + time.minute / 60.0;

  String boxKey(DateTime date) {
    final String key = '${date.day}-${date.month}-${date.year}';
    return key;
  }

  void createBoxIfAbsent(DateTime date) {
    final String key = boxKey(date);
    if (!expenseBox.containsKey(key)) {
      expenseBox.put(key, [zeroExpense]);
    }
  }

  List<Expense> expenses(DateTime expenseDate) {
    List<Expense> expenseList =
        List<Expense>.from(expenseBox.get(boxKey(expenseDate)));
    return expenseList;
  }

  List<Expense> sort(List<Expense> expenses) {
    expenses.sort(
      (firstExpense, secondExpense) =>
          toDouble(secondExpense.time).compareTo(toDouble(firstExpense.time)),
    );
    return expenses;
  }

  void add(Expense expense) async {
    List<Expense> newExpenseList = expenses(expense.date);
    if (newExpenseList[0].amount == 0) newExpenseList.clear();
    newExpenseList.add(expense);
    newExpenseList = sort(newExpenseList);
    await expenseBox.put(boxKey(expense.date), newExpenseList);
  }

  void remove(Expense expense) async {
    List<Expense> newExpenseList = expenses(expense.date);
    newExpenseList.remove(expense);
    newExpenseList = sort(newExpenseList);
    if (newExpenseList.isEmpty) newExpenseList.add(zeroExpense);
    await expenseBox.put(boxKey(expense.date), newExpenseList);
  }
}
