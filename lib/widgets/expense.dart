import 'package:flutter/material.dart';

enum Category {
  food,
  work,
  travel,
}

Map<Category, IconData> categoryIcons = {
  Category.food: Icons.fastfood_rounded,
  Category.work: Icons.laptop_rounded,
  Category.travel: Icons.directions_walk_rounded,
};

class Expense extends StatelessWidget {
  const Expense(
      {super.key,
      required this.title,
      required this.amount,
      required this.date,
      required this.time,
      required this.category});

  final String title;
  final int amount;
  final DateTime date;
  final DateTime time;
  final Category category;

  String get formattedDate => '${date.day}-${date.month}-${date.year}';
  String get formattedTime => '${time.hour}:${time.minute}';

  @override
  Widget build(BuildContext context) => Card(
        margin: const EdgeInsets.fromLTRB(12, 12, 12, 0),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(categoryIcons[category]),
                  const SizedBox(width: 8),
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        onPressed: () {}, // TODO: Add edit function
                        icon: const Icon(Icons.edit_rounded),
                      ),
                      IconButton(
                        onPressed: () {}, // TODO: Add delete functiona
                        icon: const Icon(Icons.delete_rounded),
                      )
                    ],
                  )
                ],
              ),
              const SizedBox(height: 16),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text('₹ ${amount.toString()}'),
                  const Spacer(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(formattedTime),
                      Text(formattedDate),
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      );
}
