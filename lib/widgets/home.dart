import 'package:flutter/material.dart';

import 'package:spend_smart/widgets/expense.dart';
import 'package:spend_smart/widgets/expense_list.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<StatefulWidget> createState() => _Home();
}

class _Home extends State<Home> {
  final _nameController = TextEditingController();
  final _amountController = TextEditingController();

  Category _selectedCategory = Category.grocery;

  final now = DateTime.now();
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;

  final List<Expense> _registeredExpenses = [];

  @override
  void dispose() {
    _nameController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  int get amountSpent {
    int totalAmount = 0;
    for (Expense expense in _registeredExpenses) {
      totalAmount += expense.amount;
    }
    return totalAmount;
  }

  void _addExpense(Expense expense) {
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  void _showInputDialog() {
    _nameController.clear();
    _amountController.clear();

    _selectedCategory = Category.grocery;
    _selectedDate = null;
    _selectedTime = null;

    showDialog(
      context: context,
      builder: (dialogContext) => StatefulBuilder(builder: (context, setState) {
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

        return AlertDialog(
          title: const Text('Add expense'),
          content: SingleChildScrollView(
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
                        Navigator.of(dialogContext).pop();
                      },
                      child: const Text('Cancel'),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: () {
                        _addExpense(
                          Expense(
                              title: _nameController.text,
                              amount: int.tryParse(_amountController.text)!,
                              date: _selectedDate!,
                              time: _selectedTime!,
                              category: _selectedCategory),
                        );
                        Navigator.of(dialogContext).pop();
                      },
                      child: const Text('Add'),
                    )
                  ],
                )
              ],
            ),
          ),
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(scrolledUnderElevation: 0),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 24),
              child: Text(
                '₹ ${amountSpent.toString()}',
                style:
                    const TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(child: ExpenseList(expenses: _registeredExpenses)),
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: _showInputDialog,
          label: const Text('Add expense'),
          icon: const Icon(Icons.add_rounded),
        ),
      );
}
