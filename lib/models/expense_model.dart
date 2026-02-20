class ExpenseModel {
  final String id;
  final String title;
  final double amount;
  final String category;
  final DateTime date;

  ExpenseModel({
    required this.id,
    required this.title,
    required this.amount,
    required this.category,
    required this.date,
  });

  factory ExpenseModel.fromMap(Map<String, dynamic> map) {
    return ExpenseModel(
      id: map['id'],
      title: map['title'],
      amount: (map['amount'] as num).toDouble(),
      category: map['category'],
      date: DateTime.parse(map['date']),
    );
  }

  Map<String, dynamic> toMap(String userId) {
    return {
      'user_id': userId,
      'title': title,
      'amount': amount,
      'category': category,
      'date': date.toIso8601String(),
    };
  }
}