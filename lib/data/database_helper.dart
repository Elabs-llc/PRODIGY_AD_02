import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:todo/models/todo_model.dart';

class DatabaseHelper {
  static const int _dbVersion = 1;
  static const String _dbName = 'todoapp.db';
  static const String _tblName = 'todos';

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    // If _database is null, initialize it
    _database = await getDatabase();
    return _database!;
  }

  static Future<Database> getDatabase() async {
    return openDatabase(join(await getDatabasesPath(), _dbName),
        version: _dbVersion,
        onCreate: (Database db, int version) async => await db.execute(
            "CREATE TABLE IF NOT EXISTS $_tblName (id INTEGER PRIMARY KEY AUTOINCREMENT,title TEXT NOT NULL,description TEXT, date_added TEXT DEFAULT CURRENT_TIMESTAMP,completed BOOLEAN DEFAULT 0);"));
  }

  // Create
  static Future<int> addTodo(TodoModel todoModel) async {
    final Database db = await getDatabase();

    return db.insert(
      _tblName,
      todoModel.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Read
  static Future<List<TodoModel>> getAllTodos() async {
    final Database db = await getDatabase();

    final List<Map<String, dynamic>> maps = await db.query(_tblName);

    return List.generate(maps.length, (i) => TodoModel.fromMap(maps[i]));
  }

  // Update
  static Future<int> updateTodo(TodoModel todoModel) async {
    final Database db = await getDatabase();

    return db.update(_tblName, todoModel.toMap(),
        where: 'id = ?', whereArgs: [todoModel.todoId]);
  }

  // Delete
  static Future<int> deleteTodo(int id) async {
    final Database db = await getDatabase();

    return db.delete(_tblName, where: 'id = ?', whereArgs: [id]);
  }
}
