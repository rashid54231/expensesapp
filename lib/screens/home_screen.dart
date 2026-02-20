import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import '../services/expense_service.dart';
import '../models/expense_model.dart';
import 'add_expense_screen.dart';
import 'login_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final AuthService _authService = AuthService();
  final ExpenseService _expenseService = ExpenseService();

  List<ExpenseModel> expenses = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadExpenses();
  }

  void loadExpenses() async {
    final data = await _expenseService.getExpenses();
    setState(() {
      expenses = data;
      isLoading = false;
    });
  }

  void logout() async {
    await _authService.logout();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Expenses"),
        actions: [
          IconButton(
            onPressed: logout,
            icon: const Icon(Icons.logout),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddExpenseScreen()),
          );
          loadExpenses();
        },
        child: const Icon(Icons.add),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : expenses.isEmpty
          ? const Center(child: Text("No expenses yet"))
          : ListView.builder(
        itemCount: expenses.length,
        itemBuilder: (context, index) {
          final expense = expenses[index];
          return ListTile(
            title: Text(expense.title),
            subtitle: Text(expense.category),
            trailing: Text("Rs ${expense.amount}"),
            onLongPress: () async {
              await _expenseService.deleteExpense(expense.id);
              loadExpenses();
            },
          );
        },
      ),
    );
  }
}