//Akan dibuat setelah jadi database_handler
import 'package:project_workshop_kawal_desa/models/send_absen.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHandler {
  Future<Database> initializeDB()async {
    String path =  await getDatabasesPath();
    print(path);
    return openDatabase(join(path, 'report.db'),
      onCreate: (database, version) async {
      await database.execute("CREATE TABLE report"
          "(ID INTEGER PRIMARY KEY AUTOINCREMENT,"
          "ADDRESS TEXT,"
          "CMD_TYPE INTEGER,"
          "COMPANY TEXT,"
          "DESCRIPTION TEXT,"
          "GUID TEXT,"
          "IMAGE TEXT,"
          "LAT TEXT,"
          "LONG TEXT,"
          "LOCAL_IMAGE TEXT,"
          "MSG_TYPE INTEGER,"
          "NAME TEXT,"
          "STATUS TEXT,"
          "TIMESTAMP,"
          "UNIT TEXT,"
          "REPORT_TYPE TEXT,"
          "SEND TEXT)");
      }, version: 1);
  }

  Future<int> insertUser(List<SendAbsen> users) async {
    int result = 0;
    final Database db = await initializeDB();
    for(var user in users) {
      print("insertInto");
      print(sendAbsentoJson(user));
      result = await db.insert('table', user.toJson());
    }
    return result;
  }

  Future<List<SendAbsen>> retrieveUsers() async {
    final Database db = await initializeDB();
    final List<Map<String, Object>> queryResult = await db.query('report');
    return queryResult.map((e) => SendAbsen.fromJson(e)).toList();
  }

  Future<int> retrievePending() async {
    final Database db = await initializeDB();
    final List<Map<String, Object>> queryResult = await db.query(
      'report', where: "SEND = ", whereArgs: ["pending"]);
    return queryResult.map((e) => SendAbsen.fromJson(e)).toList().length;
  }
}

