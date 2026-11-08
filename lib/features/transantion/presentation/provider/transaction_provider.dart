import 'package:flutter/material.dart';
import 'package:money_management/features/transantion/data/datasources/database_helper.dart';
import 'package:money_management/features/transantion/data/model/trasnsaction_model.dart';

class TransactionProvider extends ChangeNotifier {
  List<TransactionModel> _transaction = [];
  List<TransactionModel> get transaction => _transaction;

  // load all transaction

  Future<void> loadTransaction() async {
    final data = await DatabaseHelper.instance.getAllTransaction();
    _transaction = data.map((item) => TransactionModel.fromMap(item)).toList();
    notifyListeners();
  }

  // add transaction
  Future<void> addTransaction(TransactionModel transaction) async {
    await DatabaseHelper.instance.insertTransaction(transaction.toMap());

    await loadTransaction();
  }

  // update transaction
  Future<void> updateTransaction(TransactionModel transaction) async {
    await DatabaseHelper.instance.updateTransaction(
      transaction.id!,
      transaction.toMap(),
    );
    await loadTransaction();
  }

  Future<void> deleteTransaction(TransactionModel transaction) async {
    await DatabaseHelper.instance.deleteTransaction(transaction.id!);
    await loadTransaction();
  }
  // total expense

  double get totalExpense {
    return _transaction
        .where((t) => t.type == 'Expense')
        .fold(0.0, (sum, t) => sum + t.amount);
  }

  /// total income
  double get totalIncome {
    return _transaction
        .where((t) => t.type == 'Income')
        .fold(0.0, (sum, t) => sum + t.amount);
  }

  /// total income
  double get totalTransaction {
    return totalIncome + totalExpense;
  }

  // curremt balance
  double get currentBalance {
    return totalIncome - totalExpense;
  }
}
