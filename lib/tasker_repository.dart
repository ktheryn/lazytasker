import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'model.dart';

class TaskerRepository {
  Future<Database> initializedDB() async {
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, 'tasks.db'),
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute(
          'CREATE TABLE tasks(id TEXT PRIMARY KEY, taskName TEXT, taskDate TEXT, isCheck TEXT)',
        );
      },
    );
  }

  Future<int> insertTask(List<Task> tasks) async {
    int result = 0;
    final Database db = await initializedDB();
    for (var task in tasks) {
      result = await db.insert('tasks', task.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    }
    return result;
  }

  Future<List<Task>> retrieveTask() async {
    final Database db = await initializedDB();
    final List<Map<String, Object?>> queryResult = await db.query('tasks');
    return queryResult.map((e) => Task.fromMap(e)).toList();
  }

  Future<void> deleteTask(String id) async {
    final db = await initializedDB();
    await db.delete(
      'tasks',
      where: "id = ?",
      whereArgs: [id],
    );
  }
}
