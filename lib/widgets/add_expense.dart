import 'package:flutter/material.dart';

import 'package:spend_smart/widgets/expense.dart';

class AddExpense extends StatefulWidget {
  const AddExpense({
    super.key,
    required this.onExpenseAdded,
  });

  final void Function(Expense expense) onExpenseAdded;

  @override
  State<StatefulWidget> createState() => _AddExpense();
}

class _AddExpense extends State<AddExpense> {
  final _nameController = TextEditingController();
  final _amountController = TextEditingController();

  Category _selectedCategory = Category.grocery;

  final now = DateTime.now();
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;

  void openDatePicker() async {
    final chosenDate = await showDatePicker(
        context: context,
        firstDate: DateTime(now.year - 1, now.month, now.day),
        lastDate: now);

    setState(() {
      _selectedDate = chosenDate;
    });
  }

  void openTimePicker() async {
    final now = DateTime.now();
    final chosenTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay(hour: now.hour, minute: now.minute));

    setState(() {
      _selectedTime = chosenTime;
    });
  }

  @override
  Widget build(BuildContext context) => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 4),
          TextFormField(
            decoration: const InputDecoration(
                border: OutlineInputBorder(), labelText: 'Name'),
            controller: _nameController,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Name cannot be empty';
              }
              return null;
            },
          ),
          const SizedBox(height: 8),
          TextFormField(
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Amount',
              prefixText: '₹ ',
            ),
            controller: _amountController,
            validator: (value) {
              if (value == null || int.tryParse(value)! <= 0) {
                return 'Amount cannot be less than 0';
              }
              return null;
            },
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 8),
          DropdownButtonFormField(
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
            ),
            value: _selectedCategory,
            items: Category.values
                .map(
                  (category) => DropdownMenuItem(
                    value: category,
                    child: Row(
                      children: [
                        Icon(categoryIcons[category]),
                        const SizedBox(width: 8),
                        Text(category.name.toUpperCase())
                      ],
                    ),
                  ),
                )
                .toList(),
            onChanged: (category) {
              setState(
                () {
                  _selectedCategory = category!;
                }
              );
            },
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(Icons.calendar_month_rounded),
              TextButton(
                onPressed: openDatePicker,
                child: Text(_selectedDate == null
                    ? 'Date'
                    : '${_selectedDate?.day}-${_selectedDate?.month}-${_selectedDate?.year}'),
              ),
              const Spacer(),
              const Icon(Icons.access_time_rounded),
              TextButton(
                onPressed: openTimePicker,
                child: Text(_selectedTime == null
                    ? 'Time'
                    : '${_selectedTime?.hour.toString().padLeft(2, '0')}:${_selectedTime?.minute.toString().padLeft(2, '0')}'),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Cancel'),
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                onPressed: () {
                  widget.onExpenseAdded(
                    Expense(
                        title: _nameController.text,
                        amount: int.tryParse(_amountController.text)!,
                        date: _selectedDate!,
                        time: _selectedTime!,
                        category: _selectedCategory),
                  );
                  Navigator.pop(context);
                },
                child: const Text('Add'),
              )
            ],
          )
        ],
      );
}
