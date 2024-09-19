import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:todo/models/todo_model.dart';

class DatabaseHelper {
  static const int _dbVersion = 1;
  static const String _dbName = 'todoapp.db';
  static const String _tblName = 'todos';

  static Future<Database> getDatabase() async {
    return openDatabase(join(await getDatabasesPath(), _dbName),
        version: _dbVersion,
        onCreate: (db, version) async => await db.execute(
            "CREATE TABLE IF NOT EXISTS todo_db (id INTEGER PRIMARY KEY AUTOINCREMENT,title TEXT NOT NULL,description TEXT, date_added TEXT DEFAULT CURRENT_TIMESTAMP,completed BOOLEAN DEFAULT 0);"));
  }

  static Future<int> addTodo(TodoModel todoModel) async {
    final db = await getDatabase();
    return db.insert(_tblName, {});
  }
}
