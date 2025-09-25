import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'models/issue.dart';

class DBHelper {
  // Singleton instance
  DBHelper._privateConstructor();
  static final DBHelper instance = DBHelper._privateConstructor();

  static Database? _database;

  // Getter for database
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('issues.db');
    return _database!;
  }

  // Initialize the database
  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  // Create the issues table
  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE issues(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        service TEXT NOT NULL,
        category TEXT NOT NULL,
        description TEXT,
        images TEXT NOT NULL,
        status TEXT NOT NULL
      )
    ''');
  }

  // Insert an issue
  Future<int> insertIssue(Issue issue) async {
    final db = await database;
    return await db.insert('issues', issue.toMap());
  }

  // Get all issues
  Future<List<Issue>> getAllIssues() async {
    final db = await database;
    final result = await db.query('issues', orderBy: 'id DESC');
    return result.map((map) => Issue.fromMap(map)).toList();
  }
}
