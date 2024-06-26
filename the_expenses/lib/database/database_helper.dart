import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:the_expenses/screens/home_screen/models/expense_item.dart';
import 'package:the_expenses/screens/signup_screen/models/signup_model.dart';

class DatabaseHelper {
  static const String _databaseName = "ExpensesDatabase.db";
  static const int _databaseVersion = 1;

  static Database? _db;

  DatabaseHelper._privateConstructor();

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  Future<Database?> get db async {
    if (_db != null) return _db;
    _db = await _initDatabase();
    return _db;
  }

  _initDatabase() async {
    final documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion,
        onCreate: _onCreate,
        onConfigure: _onConfigure);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute(''' CREATE TABLE ${UserTableFields.userTable} (
        ${UserTableFields.columnID} ${UserTableFields.idType},
        ${UserTableFields.columnUserId} ${UserTableFields.userIdType},
        ${UserTableFields.columnName} ${UserTableFields.nameType},
        ${UserTableFields.columnEmail} ${UserTableFields.emailType},
        ${UserTableFields.columnPhone} ${UserTableFields.phoneType},
        ${UserTableFields.columnPassword} ${UserTableFields.passwordType}
        )''');

    await db.execute('''CREATE TABLE ${ExpenseTableFields.expenseTable} (
    ${ExpenseTableFields.columnId} ${ExpenseTableFields.idType},
    ${ExpenseTableFields.columnForeignKeyId} ${ExpenseTableFields.foreignKeyIdType},
    ${ExpenseTableFields.columnDate} ${ExpenseTableFields.dateType},
    ${ExpenseTableFields.columnName} ${ExpenseTableFields.nameType},
    ${ExpenseTableFields.columnAmount} ${ExpenseTableFields.amountType},
    ${ExpenseTableFields.foreignKeyCondition}
    )''');
    // await db.execute(''' CREATE TABLE $customerTable(
    //     ${CustomerFields.columnID} INTEGER PRIMARY KEY,
    //     ${CustomerFields.columnName} TEXT NOT NULL,
    //     ${CustomerFields.columnAddress} TEXT NOT NULL,
    //     ${CustomerFields.columnEmail} TEXT NOT NULL,
    //     ${CustomerFields.columnPhone} TEXT NOT NULL,
    //     ${CustomerFields.columnDateTime} TEXT NOT NULL,
    //     id INTEGER ,
    //     FOREIGN KEY(id) REFERENCES $usersTable(${UsersFields.columnID}) ON DELETE CASCADE
    //     )''');
    // await db.execute('''CREATE TABLE $sightTable(
    //     ${SightFields.columnSightID} INTEGER PRIMARY KEY,
    //     ${SightFields.columnSightLabel} TEXT NOT NULL,
    //     ${SightFields.columnSightName} TEXT NOT NULL,
    //     ${SightFields.columnSightAddress} TEXT NOT NULL,
    //     ${SightFields.columnSightEmail} TEXT NOT NULL,
    //     ${SightFields.columnSightPhone} TEXT NOT NULL,
    //     ${SightFields.columnSightChecked} INTEGER NOT NULL,
    //     id INTEGER ,
    //     FOREIGN KEY(id) REFERENCES $customerTable(${CustomerFields.columnID}) ON DELETE CASCADE
    //     )''');
    // await db.execute('''CREATE TABLE $deviceTable(
    //     ${DeviceFields.columnDeviceID} INTEGER PRIMARY KEY,
    //     ${DeviceFields.columnDeviceSight} TEXT NOT NULL,
    //     ${DeviceFields.columnDeviceLabel} TEXT NOT NULL,
    //     ${DeviceFields.columnDeviceType} TEXT NOT NULL,
    //     ${DeviceFields.columnDeviceImage} TEXT,
    //     ${DeviceFields.columnDeviceInformation} TEXT NOT NULL,
    //     ${DeviceFields.columnDeviceChecked} TEXT NOT NULL,
    //     id INTEGER ,
    //     FOREIGN KEY(id) REFERENCES $sightTable(${SightFields.columnSightID}) ON DELETE CASCADE
    // )'''
    // );
  }

  static Future _onConfigure(Database db) async {
    await db.execute('PRAGMA foreign_keys = ON');
  }

  Future close() async {
    final db = await instance.db;
    db!.close();
  }

  //..................................... Functions ............................

  // Insert User
  Future<SignUpModel> insertUser({required SignUpModel model}) async {
    Database? db = await instance.db;

    final id = await db!.insert(UserTableFields.userTable, model.toMap());

    return model.copy(id: id);
  }

// fetch user data

  Future<SignUpModel?> fetchUser({required userId}) async {
    Database? db = await instance.db;

    final listOFMap = await db?.query(UserTableFields.userTable,
        where: '${UserTableFields.columnUserId} == ?', whereArgs: [userId]);

    if (listOFMap!.isNotEmpty) {
      return SignUpModel.fromMap(listOFMap.first);
    } else {
      return null;
    }
  }

  // add expense item
  Future<ExpenseItem?> insertExpense({required ExpenseItem item}) async {
    Database? db = await instance.db;

    int id = await db!.insert(ExpenseTableFields.expenseTable, item.toMap());

    return item.copy(id: id);
  }

  Future<List<ExpenseItem>> fetchUserExpenses({required int id}) async {
    Database? db = await instance.db;
    final listOfMap = await db!.query(ExpenseTableFields.expenseTable,
        where: '${ExpenseTableFields.columnForeignKeyId} == ?',
        whereArgs: [id]);

    List<ExpenseItem> allExpenseList = [];
    if (listOfMap.isNotEmpty) {
      for (var item in listOfMap) {
        allExpenseList.add(ExpenseItem.fromMap(item));
      }
    }
    return allExpenseList;
  }

  Future<int?> deleteExpense({required int id}) async {
    Database? db = await instance.db;
    final receiveId = await db?.delete(ExpenseTableFields.expenseTable,
        where: '${ExpenseTableFields.columnId} == ?', whereArgs: [id]);

    return receiveId;
  }

  Future<int> editExpense({required ExpenseItem item}) async {
    Database? db = await instance.db;
   final int id = await db!.update(ExpenseTableFields.expenseTable, item.toMap(),
        where: '${ExpenseTableFields.columnId} == ?', whereArgs: [item.id]);

    return id;
  }

//  Insert
// Future insert(
//     {required Map<String, dynamic> row, required table, tempId}) async {
//   Database? db = await instance.db;
//   if (table == sightTable) {
//     int checked = row['checked'] == true ? 1 : 0;
//     const columns =
//         '${SightFields.columnSightLabel},${SightFields.columnSightName},${SightFields.columnSightAddress},${SightFields.columnSightEmail},${SightFields.columnSightPhone},${SightFields.columnSightChecked},id';
//     final id = await db!
//         .rawInsert('INSERT INTO $table($columns)VALUES(?,?,?,?,?,?,?)', [
//       '${row['label']}',
//       '${row['name']}',
//       '${row['address']}',
//       '${row['email']}',
//       '${row['phone']}',
//       '$checked',
//       '$tempId'
//     ]);
//     return id;
//   } else if (table == deviceTable) {
//     int checked = row['checked'] == true ? 1 : 0;
//     const columns =
//         '${DeviceFields.columnDeviceSight},${DeviceFields.columnDeviceLabel},${DeviceFields.columnDeviceType},${DeviceFields.columnDeviceImage},${DeviceFields.columnDeviceInformation},${DeviceFields.columnDeviceChecked},id';
//     final id = await db!
//         .rawInsert('INSERT INTO $table($columns) VALUES (?,?,?,?,?,?,?)', [
//       '${row['sight']}',
//       '${row['label']}',
//       '${row['type']}',
//       '${row['image']}',
//       '${row['information']}',
//       '$checked',
//       '$tempId'
//     ]);
//     return id;
//   } else if (table == customerTable) {
//     const columns =
//         '${CustomerFields.columnName},${CustomerFields.columnAddress},${CustomerFields.columnEmail},${CustomerFields.columnPhone},${CustomerFields.columnDateTime},id';
//     final id = await db!
//         .rawInsert('INSERT INTO $table($columns) VALUES (?,?,?,?,?,?)', [
//       '${row['name']}',
//       '${row['address']}',
//       '${row['email']}',
//       '${row['phone']}',
//       '${row['dateTime']}',
//       '$tempId'
//     ]);
//     return id;
//   } else {
//     return null;
//   }
// }
//
// // Query
// Future<List<Map<String, dynamic>>?> queryAllRow({
//   required table,
//   column,
//   value,
// }) async {
//   Database? db = await instance.db;
//   if (value == null) {
//     if (table == customerTable) {
//       return await db!.rawQuery('''SELECT * FROM $customerTable''');
//     } else if (table == sightTable) {
//       return await db!.rawQuery('''SELECT * FROM $sightTable''');
//     } else if (table == deviceTable) {
//       return await db!.rawQuery('''SELECT * FROM $deviceTable''');
//     }
//   } else {
//     if (table == customerTable) {
//       return await db!
//           .rawQuery('''SELECT * FROM $table WHERE $column = ?''', [value]);
//     } else if (table == sightTable) {
//       return await db!
//           .rawQuery('''SELECT * FROM $table WHERE $column = ?''', [value]);
//     } else if (table == deviceTable) {
//       return await db!
//           .rawQuery('''SELECT * FROM $table WHERE $column = ?''', [value]);
//     }
//   }
//   return null;
// }
//
// // Delete
// Future<int?> delete({required id, required table}) async {
//   Database? db = await instance.db;
//   if (table == customerTable) {
//     return await db!.rawDelete('''DELETE FROM $table WHERE _id = ?''', [id]);
//   } else if (table == sightTable) {
//     return await db!
//         .rawDelete('''DELETE FROM $table WHERE _sightId = ?''', [id]);
//   } else if (table == deviceTable) {
//     return await db!
//         .rawDelete('''DELETE FROM $table WHERE _deviceId = ?''', [id]);
//   }
//   return null;
// }
//
// // Update
// Future<int> update(
//     {required Map<String, dynamic> updatedRow,
//     required table,
//     required tempId}) async {
//   Database? db = await instance.db;
//   if (table == customerTable) {
//     return await db!.update(
//         table,
//         {
//           CustomerFields.columnName: updatedRow['name'],
//           CustomerFields.columnAddress: updatedRow['address'],
//           CustomerFields.columnEmail: updatedRow['email'],
//           CustomerFields.columnPhone: updatedRow['phone'],
//         },
//         where: '_id = ?',
//         whereArgs: [tempId]);
//   } else if (table == sightTable) {
//     int checked = updatedRow['checked'] == true ? 1 : 0;
//     return await db!.update(
//         table,
//         {
//           SightFields.columnSightLabel: updatedRow['label'],
//           SightFields.columnSightName: updatedRow['name'],
//           SightFields.columnSightAddress: updatedRow['address'],
//           SightFields.columnSightEmail: updatedRow['email'],
//           SightFields.columnSightPhone: updatedRow['phone'],
//           SightFields.columnSightChecked: checked
//         },
//         where: '_sightId = ?',
//         whereArgs: [tempId]);
//   } else if (table == deviceTable) {
//     int checked = updatedRow['checked'] == true ? 1 : 0;
//     return await db!.update(
//         table,
//         {
//           DeviceFields.columnDeviceSight: updatedRow['sight'],
//           DeviceFields.columnDeviceLabel: updatedRow['label'],
//           DeviceFields.columnDeviceType: updatedRow['type'],
//           DeviceFields.columnDeviceImage: updatedRow['image'],
//           DeviceFields.columnDeviceInformation: updatedRow['information'],
//           DeviceFields.columnDeviceChecked: checked
//         },
//         where: '_deviceId = ?',
//         whereArgs: [tempId]);
//   }
//   return 0;
// }
//
// //   Device Group list query
// Future groupQuery({required table, required id, required value}) async {
//   Database? db = await instance.db;
//   return await db!.rawQuery(
//       '''SELECT $id, COUNT(*) FROM $table WHERE $id = ? GROUP BY $id''',
//       [value]);
// }
//
// Future totalDevice() async {
//   Database? db = await instance.db;
//   return await db!.rawQuery(
//       '''SELECT COUNT(*) FROM (SELECT C._id,C._sightId,Devices._deviceId FROM (SELECT Customer._id,Sight._sightId FROM Customer INNER JOIN Sight ON Customer._id = Sight.id) AS C INNER JOIN Devices ON C._sightId = Devices.id) GROUP BY _id''');
// }
//
// Future findUser({required uid}) async {
//   Database? db = await instance.db;
//   return await db!.rawQuery(
//       '''SELECT ${UsersFields.columnID} FROM $usersTable WHERE ${UsersFields.columnUserId} =
//   ?
//   ''', [uid]);
// }
}
