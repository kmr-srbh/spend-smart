import 'package:flutter/material.dart';

import 'package:spend_smart/widgets/expense.dart';

class AddExpense extends StatefulWidget {
  const AddExpense({
    super.key,
    required this.onExpenseAdded,
  });

  final void Function(Expense expense) onExpenseAdded;

  @override
  State<StatefulWidget> createState() => _AddExpenseState();
}

class _AddExpenseState extends State<AddExpense> {
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

  void _validateInput() {
    final int? amount = int.tryParse(_amountController.text);
    final bool isInvalidAmount = amount == null || amount <= 0;
    if (_nameController.text.trim().isEmpty ||
        isInvalidAmount ||
        _selectedDate == null ||
        _selectedTime == null) {
      showDialog(
        context: context,
        builder: (dialogContext) => AlertDialog(
          title: const Row(
            children: [
              Icon(Icons.warning_rounded),
              SizedBox(width: 8),
              Text('Something is not right')
            ],
          ),
          content: const Text(
              'Please check the data you have entered to see if it is correct.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: const Text('Okay'),
            )
          ],
        ),
      );
      return;
    }

    widget.onExpenseAdded(
      Expense(
          title: _nameController.text,
          amount: int.tryParse(_amountController.text)!,
          date: _selectedDate!,
          time: _selectedTime!,
          category: _selectedCategory),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 4),
          TextField(
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Name',
            ),
            controller: _nameController,
          ),
          const SizedBox(height: 8),
          TextField(
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Amount',
              prefixText: '₹ ',
            ),
            controller: _amountController,
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
                },
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
                onPressed: _validateInput,
                child: const Text('Add'),
              )
            ],
          )
        ],
      );
}
