

class TransactionModel {
  final int? id;
  final String title;
  final double amount;
  final String category;
  final String type; // 'Income' or 'Expense'
  final String date;  // Stored as ISO8601 String (e.g., '2026-11-08')

  TransactionModel({
    this.id,
    required this.title,
    required this.amount,
    required this.category,
    required this.type,
    required this.date,
  });

  // Convert a Transaction object into a Map to insert into the Database
  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id,
      'title': title,
      'amount': amount,
      'category': category,
      'type': type,
      'date': date,
    };
  }

  // Extract a Transaction object from a Database Map
  factory TransactionModel.fromMap(Map<String, dynamic> map) {
    return TransactionModel(
      id: map['id'] as int?,
      title: map['title'] as String,
      amount: (map['amount'] as num).toDouble(),
      category: map['category'] as String,
      type: map['type'] as String,
      date: map['date'] as String,
    );
  }}