import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class dbhelper {
  Future<Database> createdatabase() async {
    // Get a location using getDatabasesPath
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'demo.db');

    // open the database
    Database database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      // When creating the db, create the table
      await db.execute(
          'CREATE TABLE Test (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, email TEXT, contact TEXT,password TEXT)');
    });
    return database;
  }
}
