import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:rtm_template_one/data_layer/models/Truck.dart';
import 'package:rtm_template_one/data_layer/models/User.dart';
import 'package:sqflite/sqflite.dart';


class DatabaseHelper {
  static const _databaseName = 'rmt.db';
  static const _databaseVersion = 2;

  DatabaseHelper._();
  static final DatabaseHelper instance = new DatabaseHelper._();
  Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await getDatabaseInstance();
    return _database;
  }

  Future<Database> getDatabaseInstance() async {
    final directory = await getDatabasesPath();
    String path = join(directory, _databaseName);
    //deleteDatabase(path);
    return await openDatabase(
      path,
      version: _databaseVersion,
      onUpgrade: (Database db, int oldVersion, int newVersion) async {
        debugPrint('Database onUpgrade');

      },
      onCreate: (Database db, int version) async {
        debugPrint('Database OnCreate');
        await db.execute(
          "CREATE TABLE users(id INTEGER PRIMARY KEY AUTOINCREMENT, username TEXT, email TEXT, user_created TIMESTAMP "
          "DEFAULT CURRENT_TIMESTAMP)",
        );
        await db.execute(
         "CREATE TABLE trucks(id INTEGER PRIMARY KEY AUTOINCREMENT, truckName TEXT, truckNumber TEXT,"
             " driver TEXT, status TEXT,truckType TEXT)",
        );
       // await db.execute("CREATE TRIGGER trg_remove_session "
      //      "AFTER INSERT "
       //     "ON users "
       //     "BEGIN "
       //     "DELETE FROM users WHERE DATE(user_created) < DATE('now', '-1 days'); "
        //    "END;");
      },
    );
  }

  Future<List<User>> users() async {
    final db = await database;
    final List<Map<String, dynamic>> userMaps = await db.rawQuery('select * from users');
    print(userMaps);
    return List.generate(userMaps.length, (i) {
      return User(
        name: userMaps[i]['username'],
        email: userMaps[i]['email'],
      );
    });
  }

  Future<List<Truck>> trucks() async {
    final db = await database;
    final List<Map<String, dynamic>> truckMaps = await db.query('trucks');
    return List.generate(truckMaps.length, (i) {
      return Truck(
        id: truckMaps[i]['id'] as int,
        truckName: truckMaps[i]['truckName'] as String,
        truckNumber: truckMaps[i]['truckNumber'] as String,
        driver: truckMaps[i]['driver'] as String,
        status: truckMaps[i]['status'] as String,
        truckType: truckMaps[i]['truckType'] as String,
      );
    });
  }

  Future<void> insertTruck(Truck truck) async {
    final db = await database;
    await db.insert(
      'trucks',
      truck.toMap(),
    );
  }
  Future<bool> insertUser(User user) async {
    bool checkInsert = false;
    try {
      final db = await database;
      int newId =  await db.insert(
        'users',
      user.toJson(),
      );
      checkInsert = true;
    }
    catch (e){
      checkInsert = false;
    }
    return checkInsert;

  }

 /* Future<void> updateUser(User user) async {
    final db = await database;
    await db.update(
      'users',
      user.toJson(),
      where: "username = ?",
      whereArgs: [user.name],
    );
  }*/
  Future<void> deleteUser(String id) async {
    final db = await database;
    await db.delete(
      'users',
      where: "username = ?",
      whereArgs: [id],
    );
  }

  Future<void> deleteAllUsers() async {
    final db = await database;
    await db.delete(
      'users',
    );
  }
}
