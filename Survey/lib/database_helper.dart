import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static const _databasename = "surveydatabase.db";
  static const _databaseversion = 1;

  static const table1 = "Customer";
  static const table1_Column1 = "_id";
  static const table1_Column2 = "Name";
  static const table1_Column3 = "Address";
  static const table1_Column4 = "Email";
  static const table1_Column5 = "Phone";

  // static const table2 = "Sight";
  // static const table2_Column1 = "_Sightid";
  // static const table2_Column2 = "Name";
  // static const table2_Column3 = "Address";
  // static const table2_Column4 = "Email";
  // static const table2_Column5 = "Phone";

  late Database _db;

  Future<void> init() async {
    final documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, _databasename);
    _db = await openDatabase(path,
        version: _databaseversion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute(''' CREATE TABLE $table1(
        $table1_Column1 INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
        $table1_Column2 CHAR(25) NOT NULL,
        $table1_Column3 VARCHAR(255) NOT NULL,
        $table1_Column4 VARCHAR(255) NOT NULL,
        $table1_Column5 INT(10) NOT NULL
        )''');
  }

  // for insert row in table
  Future<int> insert(Map<String, dynamic> row) async {
    return await _db.insert(table1, row);
  }

  // Fetching Data
  Future<List<Map<String, dynamic>>> queryAllRow() async {
    return _db.query(table1);
  }

  // Update
  Future update(Map<String, dynamic> row) async {
    int id = row[table1_Column1];
    return await _db
        .update(table1, row, where: '$table1_Column1=?', whereArgs: [id]);
  }

  Future<int> delete(int id) async {
    return await _db
        .delete(table1, where: '$table1_Column1 = ?', whereArgs: [id]);
  }

  //
}
