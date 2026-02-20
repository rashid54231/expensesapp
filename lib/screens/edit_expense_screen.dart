import 'package:flutter/material.dart';
import '../models/expense_model.dart';
import '../services/expense_service.dart';

class EditExpenseScreen extends StatefulWidget {
  final ExpenseModel expense;

  const EditExpenseScreen({super.key, required this.expense});

  @override
  State<EditExpenseScreen> createState() => _EditExpenseScreenState();
}

class _EditExpenseScreenState extends State<EditExpenseScreen> {
  late TextEditingController titleController;
  late TextEditingController amountController;
  late TextEditingController categoryController;

  final ExpenseService _expenseService = ExpenseService();

  @override
  void initState() {
    super.initState();
    titleController =
        TextEditingController(text: widget.expense.title);
    amountController =
        TextEditingController(text: widget.expense.amount.toString());
    categoryController =
        TextEditingController(text: widget.expense.category);
  }

  void updateExpense() async {
    final updatedExpense = ExpenseModel(
      id: widget.expense.id,
      title: titleController.text,
      amount: double.parse(amountController.text),
      category: categoryController.text,
      date: DateTime.now(),
    );

    await _expenseService.updateExpense(
      widget.expense.id,
      updatedExpense,
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Edit Expense")),
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
              onPressed: updateExpense,
              child: const Text("Update"),
            )
          ],
        ),
      ),
    );
  }
}