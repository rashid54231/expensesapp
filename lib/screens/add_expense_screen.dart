import 'package:flutter/material.dart';
import '../models/expense_model.dart';
import '../services/expense_service.dart';

class AddExpenseScreen extends StatefulWidget {
  const AddExpenseScreen({super.key});

  @override
  State<AddExpenseScreen> createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  final categoryController = TextEditingController();

  final ExpenseService _expenseService = ExpenseService();

  void saveExpense() async {
    final expense = ExpenseModel(
      id: '',
      title: titleController.text,
      amount: double.parse(amountController.text),
      category: categoryController.text,
      date: DateTime.now(),
    );

    await _expenseService.addExpense(expense);

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Expense")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: "Title"),
            ),
            TextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: "Amount"),
            ),
            TextField(
              controller: categoryController,
              decoration: const InputDecoration(labelText: "Category"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: saveExpense,
              child: const Text("Save"),
            )
          ],
        ),
      ),
    );
  }
}