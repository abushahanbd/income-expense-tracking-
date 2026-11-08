import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  DatabaseHelper._init();
  static Database? _database;
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _intDB('task_manager.db');

    return _database!;
  }

  Future<Database> _intDB(String fileName) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, fileName);
    return await openDatabase(path, version: 1, onCreate: _createDb);
  }

  Future<void> _createDb(Database db, int version) async {
    await db.execute('''
      CREATE TABLE money_management (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        amount REAL NOT NULL,
        category TEXT NOT NULL,
        type TEXT NOT NULL,
        date TEXT NOT NULL
      )
    ''');
  }
  // inseart transaction

  Future<int> insertTransaction(Map<String, dynamic> data) async {
    final db = await database;

    return await db.insert('money_management', data);
  }

  // Get All Transactions
  Future<List<Map<String, dynamic>>> getAllTransaction() async {
    final db = await database;
    return db.query('money_management', orderBy: 'date DESC, id DESC');
  }
  // update transaction

  Future<int> updateTransaction(int id, Map<String, dynamic> data) async {
    final db = await database;

    return await db.update(
      'money_management',
      data,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Delete Transaction
  Future<int> deleteTransaction(int id) async {
    final db = await database;
    return await db.delete(
      'money_management',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
