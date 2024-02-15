import 'package:flutter/material.dart';

import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'expense.g.dart';

Uuid uuid = const Uuid();

@HiveType(typeId: 1)
enum Category {
  @HiveField(0)
  grocery,

  @HiveField(1)
  work,

  @HiveField(2)
  travel,

  @HiveField(3)
  leisure,

  @HiveField(4)
  bills,

  @HiveField(5)
  medical,
}

Map<Category, IconData> categoryIcons = {
  Category.grocery: Icons.local_grocery_store_rounded,
  Category.work: Icons.laptop_rounded,
  Category.travel: Icons.directions_walk_rounded,
  Category.leisure: Icons.restaurant_rounded,
  Category.bills: Icons.currency_rupee_rounded,
  Category.medical: Icons.local_hospital_rounded,
};

@HiveType(typeId: 0)
class Expense {
  Expense({
    required this.name,
    required this.amount,
    required this.category,
    required this.date,
    required this.time,
  }) : id = uuid.v4();

  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final int amount;

  @HiveField(3)
  final Category category;

  @HiveField(4)
  final DateTime date;

  @HiveField(5)
  final TimeOfDay time;

  String get formattedDate =>
      '${date.day.toString().padLeft(2, '0')}-${date.month.toString().padLeft(2, '0')}-${date.year}';
  String get formattedTime =>
      '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
}

final Expense zeroExpense = Expense(
  name: 'Zero Expense',
  amount: 0,
  category: Category.grocery,
  date: DateTime.now(),
  time: TimeOfDay.now(),
);
