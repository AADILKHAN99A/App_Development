import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static const _databaseName = "surveyDatabase.db";
  static const _databaseVersion = 1;

  static const table1 = "User";
  static const columnID = "_id";
  static const columnName = "Name";
  static const columnAddress = "Address";
  static const columnEmail = "Email";
  static const columnPhone = "Phone";

  static Database? _db;

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  Future<Database?> get db async{
    if(_db != null) return _db;
    _db =await _initDatabase();
    return _db;
  }


  _initDatabase() async {
    final documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute(''' CREATE TABLE $table1(
        $columnID INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
        $columnName CHAR(25) NOT NULL,
        $columnAddress VARCHAR(255) NOT NULL,
        $columnEmail VARCHAR(255) NOT NULL,
        $columnPhone INT(10) NOT NULL
        )''');
  }


  //..................................... Functions ............................


  //  Insert
  Future<int> insert(Map<String, dynamic> row) async {
    Database? db =await instance.db;
    return await db!.insert(table1, row);
  }

  // Query All Row
  Future<List<Map<String, dynamic>>> queryAllRow() async {
    return _db!.query(table1);
  }

  // Update
  // Future update(Map<String, dynamic> row) async {
  //   int id = row[table1_Column1];
  //   return await _db
  //       .update(table1, row, where: '$table1_Column1=?', whereArgs: [id]);
  // }
  //
  // Future<int> delete(int id) async {
  //   return await _db
  //       .delete(table1, where: '$table1_Column1 = ?', whereArgs: [id]);
  // }

  //
}
