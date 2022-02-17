import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:accounts/infoModel/Model.dart';
import 'dart:async';
import 'package:accounts/library/filePath.dart';

class SqlLight{

  final String  namesTable = "namesTable";
  final String id = "id";
  final String webNames = "webName";
  final String  emails = "Email";
  final String  passwordApps = "passward";

  static  Database? database ;


  Future<Database?> get db async {
    if (database == null) {
      database = await _createBase();
      return database;
    }
    else {
      return database;
    }
  }

  _createBase() async {

    String databasePath = await getDatabasesPath();
    String path = join(databasePath , 'Acounts.db');
    var db = await openDatabase(path , version: 4 , onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db, int version) async {

    await db.execute('CREATE TABLE $namesTable ($id INTEGER PRIMARY KEY,'
        ' $webNames TEXT, $emails TEXT, $passwordApps TEXT);'
    );

  }

  ///ENTER_VALUE_TO_DATA_METHOD

  Future<int> saveNT(Model todo) async {
    var dbClient = await db;
    var result = await dbClient?.insert(namesTable, todo.toMap());
    if(result != null)
    return result;
    else return 0;
  }

  ///READ_METHOD
  Future<List> retrieveN() async{
    var dbClient = await db;
    if (dbClient != null) {
      var result = await dbClient.query(
          namesTable,
          columns:
          [id,
            webNames,
            emails,
            passwordApps]
      );
      return result.toList();
    } else return new List.empty();
  }

  ///DELETE_METHOD

  Future<int> delete(int? idi) async {
    var dbClient = await db;
    if(dbClient != null) {
      return await dbClient.delete(
          namesTable, where: "$id = ?", whereArgs: [idi]
      );
    }
    else return 0;
  }


  ///UPDATE_METHOD

  Future<int> upDate(Model todo, int? idr) async {

    var dbClient = await db;
    if(dbClient != null) {
      int updated = await dbClient.update(namesTable, todo.toMap(),
          where: '$id = ?', whereArgs: [idr]);
      return updated;
    } else return 0;
  }

  Future<File> backup( String fileName) async{

    var path = await db;
    if(path != null) {
      var exists = await databaseExists(path.path);
      var mydatapath = path.path;

      try {
        if (!exists) {
          print("data not exist");
          return File('....');
        } else {
          // Copy
          var data1 = await File(mydatapath).readAsBytes();
          //print(await File(mydatapath).readAsBytes());
          List<int> bytes =
          data1.buffer.asUint8List(data1.offsetInBytes, data1.lengthInBytes);
          FilePath getPath = new FilePath();
          final pathd = await getPath.appFile();
          return await File('$pathd/$fileName' + '.db').writeAsBytes(bytes);
        }
      } catch (e) {
        print(e);
        return File('....');
      }
    }else return new File('....');

  }


  Future<List> readExsSqlBase(var path) async{
    var db1 = await openDatabase(path);
    try {
      var result = await db1.query(
          namesTable,
          columns:
          [id,
            webNames,
            emails,
            passwordApps]
      );

      await db1.close();
      return result.toList();
    } catch(e) {
      print(e);
      return new List.empty();
    }
  }

  Future<List> searchByName(String webName) async{
    var dbClient = await db;
    if(dbClient != null) {
      var result = await dbClient.rawQuery("SELECT * FROM "
          "$namesTable WHERE $webNames "
          "LIKE '%$webName%'");

      return result.toList();
    }  else return new List.empty();
  }

  Future drop() async {
    var path = await db;
    if(path != null)
  return  await deleteDatabase(path.path);

  }

  Future close() async {
    var dbClient = await db;
    if(dbClient != null)
      dbClient.close();
  }

}