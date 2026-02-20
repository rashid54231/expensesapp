import 'package:supabase_flutter/supabase_flutter.dart';
import '../config/supabase_config.dart';
import '../models/expense_model.dart';

class ExpenseService {
  final SupabaseClient _client = SupabaseConfig.client;

  // ===========================
  // GET ALL EXPENSES
  // ===========================
  Future<List<ExpenseModel>> getExpenses() async {
    final user = _client.auth.currentUser;

    if (user == null) {
      throw Exception("User not logged in");
    }

    final response = await _client
        .from('expenses')
        .select()
        .eq('user_id', user.id)
        .order('date', ascending: false);

    return (response as List)
        .map((e) => ExpenseModel.fromMap(e))
        .toList();
  }

  // ===========================
  // ADD EXPENSE
  // ===========================
  Future<void> addExpense(ExpenseModel expense) async {
    final user = _client.auth.currentUser;

    if (user == null) {
      throw Exception("User not logged in");
    }

    await _client.from('expenses').insert(
      expense.toMap(user.id),
    );
  }

  // ===========================
  // UPDATE EXPENSE
  // ===========================
  Future<void> updateExpense(
      String id, ExpenseModel expense) async {
    await _client
        .from('expenses')
        .update({
      'title': expense.title,
      'amount': expense.amount,
      'category': expense.category,
      'date': expense.date.toIso8601String(),
    })
        .eq('id', id);
  }

  // ===========================
  // DELETE EXPENSE
  // ===========================
  Future<void> deleteExpense(String id) async {
    await _client
        .from('expenses')
        .delete()
        .eq('id', id);
  }

  // ===========================
  // GET TOTAL EXPENSE AMOUNT
  // ===========================
  Future<double> getTotalExpenses() async {
    final expenses = await getExpenses();

    double total = 0;
    for (var expense in expenses) {
      total += expense.amount;
    }

    return total;
  }

  // ===========================
  // GET TOTAL BY CATEGORY
  // ===========================
  Future<double> getTotalByCategory(String category) async {
    final expenses = await getExpenses();

    double total = 0;
    for (var expense in expenses) {
      if (expense.category == category) {
        total += expense.amount;
      }
    }

    return total;
  }
}