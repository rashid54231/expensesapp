import 'package:flutter/material.dart';
import '../services/expense_service.dart';
import '../models/expense_model.dart';
import 'login_screen.dart';
import 'expense_form_screen.dart';  // ← yeh ek hi screen add aur edit dono ke liye

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ExpenseService _expenseService = ExpenseService();
  List<ExpenseModel> expenses = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadExpenses();
  }

  Future<void> _loadExpenses() async {
    try {
      final data = await _expenseService.getExpenses();
      setState(() {
        expenses = data;
        isLoading = false;
      });
    } catch (e) {
      setState(() => isLoading = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error: $e")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Expenses"),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const LoginScreen()),
              );
            },
          ),
        ],
      ),

      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : expenses.isEmpty
          ? const Center(child: Text("No expenses added yet\nTap + to add one"))
          : RefreshIndicator(
        onRefresh: _loadExpenses,
        child: ListView.builder(
          itemCount: expenses.length,
          itemBuilder: (context, index) {
            final expense = expenses[index];
            return ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.blue.shade100,
                child: Text(
                  expense.category.isNotEmpty ? expense.category[0].toUpperCase() : '?',
                ),
              ),
              title: Text(expense.title),
              subtitle: Text(expense.category),
              trailing: Text(
                "Rs ${expense.amount.toStringAsFixed(0)}",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
              onTap: () {
                // Edit mode mein jaao (same screen, expense pass karke)
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ExpenseFormScreen(
                      expenseToEdit: expense,  // ← yeh pass kar rahe hain edit ke liye
                    ),
                  ),
                ).then((_) => _loadExpenses()); // wapas aane pe list refresh
              },
            );
          },
        ),
      ),

      // Sirf ek + button (Add ke liye)
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const ExpenseFormScreen(),  // naya expense → expenseToEdit null
            ),
          ).then((_) => _loadExpenses()); // save hone ke baad refresh
        },
        child: const Icon(Icons.add),
        tooltip: 'Add Expense',
      ),
    );
  }
}