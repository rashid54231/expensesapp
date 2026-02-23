// lib/screens/expense_form_screen.dart
import 'package:flutter/material.dart';
import '../models/expense_model.dart';  // agar model import karna hai

class ExpenseFormScreen extends StatefulWidget {
  final ExpenseModel? expenseToEdit;  // edit mode ke liye (null = add new)

  const ExpenseFormScreen({
    super.key,
    this.expenseToEdit,
  });

  @override
  State<ExpenseFormScreen> createState() => _ExpenseFormScreenState();
}

class _ExpenseFormScreenState extends State<ExpenseFormScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.expenseToEdit == null ? 'Add Expense' : 'Edit Expense',
        ),
      ),
      body: const Center(
        child: Text(
          'Expense Form Coming Soon...\n\n(Yeh screen abhi placeholder hai)',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}