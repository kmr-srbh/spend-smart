import 'package:flutter/material.dart';

import 'package:spend_smart/models/expense.dart';
import 'package:spend_smart/widgets/data_manager.dart';

class AddExpenseForm extends StatefulWidget {
  const AddExpenseForm({super.key});

  @override
  State<StatefulWidget> createState() => _AddExpenseFormState();
}

class _AddExpenseFormState extends State<AddExpenseForm> {
  final DataManager dataManager = DataManager();

  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _amountController = TextEditingController();

  Category? _selectedCategory;

  final now = DateTime.now();
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _amountController.dispose();
  }

  void _openDatePicker() async {
    final DateTime? chosenDate = await showDatePicker(
        context: context,
        firstDate: DateTime(now.year - 1, now.month, now.day),
        lastDate: now,
        initialDate: _selectedDate);

    setState(() {
      if (chosenDate != null) _selectedDate = chosenDate;
    });
  }

  void _openTimePicker() async {
    final TimeOfDay? chosenTime = await showTimePicker(
        context: context,
        initialTime:
            TimeOfDay(hour: _selectedTime.hour, minute: _selectedTime.minute));

    setState(() {
      if (chosenTime != null) _selectedTime = chosenTime;
    });
  }

  @override
  Widget build(BuildContext context) => Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            TextFormField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Name',
              ),
              controller: _nameController,
              autovalidateMode: AutovalidateMode.onUserInteraction,
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
              keyboardType: TextInputType.number,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                final int? amount = int.tryParse(_amountController.text);
                if (amount == null) {
                  return 'Amount cannot be empty';
                } else if (amount <= 0) {
                  return 'Please enter a valid amount';
                }
                return null;
              },
            ),
            const SizedBox(height: 8),
            DropdownButtonFormField(
              hint: const Text('Category'),
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
                setState(() {
                  _selectedCategory = category;
                });
              },
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                if (value == null) {
                  return 'Please select a category';
                }
                return null;
              },
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.calendar_month_rounded),
                TextButton(
                  onPressed: _openDatePicker,
                  child: Text(
                      '${_selectedDate.day.toString().padLeft(2, '0')}-${_selectedDate.month.toString().padLeft(2, '0')}-${_selectedDate.year}'),
                ),
                const Spacer(),
                const Icon(Icons.access_time_rounded),
                TextButton(
                  onPressed: _openTimePicker,
                  child: Text(
                      '${_selectedTime.hour.toString().padLeft(2, '0')}:${_selectedTime.minute.toString().padLeft(2, '0')}'),
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
                    if (_formKey.currentState!.validate()) {
                      dataManager.add(
                        Expense(
                          name: _nameController.text,
                          amount: int.tryParse(_amountController.text) as int,
                          category: _selectedCategory as Category,
                          date: _selectedDate,
                          time: _selectedTime,
                        ),
                      );
                      Navigator.pop(context);
                    }
                  },
                  child: const Text('Add'),
                )
              ],
            )
          ],
        ),
      );
}
