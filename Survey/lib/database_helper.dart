import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:survey/datamodels.dart';

class DatabaseHelper {
  static const _databaseName = "SurveyDatabase.db";
  static const _databaseVersion = 1;

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
    await db.execute(''' CREATE TABLE $customerTable(
        ${CustomerFields.columnID} INTEGER PRIMARY KEY,
        ${CustomerFields.columnName} TEXT NOT NULL,
        ${CustomerFields.columnAddress} TEXT NOT NULL,
        ${CustomerFields.columnEmail} TEXT NOT NULL,
        ${CustomerFields.columnPhone} TEXT NOT NULL,
        ${CustomerFields.columnDateTime} TEXT NOT NULL
        )''');
    await db.execute('''CREATE TABLE $sightTable(
        ${SightFields.columnSightID} INTEGER PRIMARY KEY,
        ${SightFields.columnSightLabel} TEXT NOT NULL,
        ${SightFields.columnSightName} TEXT NOT NULL,
        ${SightFields.columnSightAddress} TEXT NOT NULL,
        ${SightFields.columnSightEmail} TEXT NOT NULL,
        ${SightFields.columnSightPhone} TEXT NOT NULL,
        ${SightFields.columnSightChecked} INTEGER NOT NULL,
        id INTEGER ,
        FOREIGN KEY(id) REFERENCES $customerTable(${CustomerFields.columnID}) ON DELETE CASCADE
        )''');
    await db.execute('''CREATE TABLE $deviceTable(
        ${DeviceFields.columnDeviceID} INTEGER PRIMARY KEY,
        ${DeviceFields.columnDeviceSight} TEXT NOT NULL,
        ${DeviceFields.columnDeviceLabel} TEXT NOT NULL,
        ${DeviceFields.columnDeviceType} TEXT NOT NULL,
        ${DeviceFields.columnDeviceImage} TEXT,
        ${DeviceFields.columnDeviceInformation} TEXT NOT NULL,
        ${DeviceFields.columnDeviceChecked} TEXT NOT NULL,
        id INTEGER ,
        FOREIGN KEY(id) REFERENCES $sightTable(${SightFields.columnSightID}) ON DELETE CASCADE
    )''');
    preListAdder();
  }

  static Future _onConfigure(Database db) async {
    await db.execute('PRAGMA foreign_keys = ON');
  }

  Future close() async {
    final db = await instance.db;
    db!.close();
  }

  Future preListAdder() async {
    List preCustomerList = [
      {
        "name": "Dwayne Douglas",
        "address": "2451 University Mobile, AL 36617",
        "email": "",
        "phone": "",
        "dateTime": "25 July 2023 5:41 pm"
      },
      {
        "name": "Dwayne Douglas",
        "address": "2451 University Mobile, AL 36617",
        "email": "",
        "phone": "",
        "dateTime": "26 July 2023 5:41 pm"
      },
      {
        "name": "Dwayne Douglas",
        "address": "2451 University Mobile, AL 36617",
        "email": "",
        "phone": "",
        "dateTime": "27 July 2023 5:41 pm"
      },
      {
        "name": "Dwayne Douglas",
        "address": "2451 University Mobile, AL 36617",
        "email": "",
        "phone": "",
        "dateTime": "28 July 2023 5:41 pm"
      }
    ];
    List preSightList = [
      {
        "label": "Sight 1",
        "name": "",
        "address": "",
        "email": "",
        "phone": "",
        "checked": false,
      }
    ];
    List preDeviceList = [
      {
        "sight": "Sight 1",
        "label": "Panel information",
        "type": "panel",
        "image": "",
        "information": "",
        "checked": false
      },
      {
        "sight": "Sight 1",
        "label": "AC",
        "type": "panel",
        "image": "",
        "information": "",
        "checked": false
      },
      {
        "sight": "Sight 1",
        "label": "Heater information",
        "type": "panel",
        "image": "",
        "information": "",
        "checked": false
      },
      {
        "sight": "Sight 1",
        "label": "PowerX setup",
        "type": "panel",
        "image": "",
        "information": "",
        "checked": false
      },
    ];

    for (int i = 0; i < preCustomerList.length; i++) {
      var id = await insert(row: preCustomerList[i], table: customerTable);

      for (int j = 0; j < preSightList.length; j++) {
        var sightid =
            await insert(row: preSightList[j], table: sightTable, tempId: id);
        for (int k = 0; k < preDeviceList.length; k++) {
          var deviceid = await insert(
              row: preDeviceList[k], table: deviceTable, tempId: sightid);
          print(deviceid);
        }
      }
    }
  }

  //..................................... Functions ............................

  //  Insert
  Future insert(
      {required Map<String, dynamic> row, required table, tempId}) async {
    Database? db = await instance.db;
    if (table == sightTable) {
      int checked = row['checked'] == true ? 1 : 0;
      const columns =
          '${SightFields.columnSightLabel},${SightFields.columnSightName},${SightFields.columnSightAddress},${SightFields.columnSightEmail},${SightFields.columnSightPhone},${SightFields.columnSightChecked},id';
      final id = await db!
          .rawInsert('INSERT INTO $table($columns)VALUES(?,?,?,?,?,?,?)', [
        '${row['label']}',
        '${row['name']}',
        '${row['address']}',
        '${row['email']}',
        '${row['phone']}',
        '$checked',
        '$tempId'
      ]);
      return id;
    } else if (table == deviceTable) {
      int checked = row['checked'] == true ? 1 : 0;
      const columns =
          '${DeviceFields.columnDeviceSight},${DeviceFields.columnDeviceLabel},${DeviceFields.columnDeviceType},${DeviceFields.columnDeviceImage},${DeviceFields.columnDeviceInformation},${DeviceFields.columnDeviceChecked},id';
      final id = await db!
          .rawInsert('INSERT INTO $table($columns) VALUES (?,?,?,?,?,?,?)', [
        '${row['sight']}',
        '${row['label']}',
        '${row['type']}',
        '${row['image']}',
        '${row['information']}',
        '$checked',
        '$tempId'
      ]);
      return id;
    } else if (table == customerTable) {
      const columns =
          '${CustomerFields.columnName},${CustomerFields.columnAddress},${CustomerFields.columnEmail},${CustomerFields.columnPhone},${CustomerFields.columnDateTime}';
      final id = await db!
          .rawInsert('INSERT INTO $table($columns) VALUES (?,?,?,?,?)', [
        '${row['name']}',
        '${row['address']}',
        '${row['email']}',
        '${row['phone']}',
        '${row['dateTime']}'
      ]);
      return id;
    } else {
      return null;
    }
  }

  // Query
  Future<List<Map<String, dynamic>>?> queryAllRow(
      {required table, tempId}) async {
    Database? db = await instance.db;
    if (tempId == null) {
      if (table == customerTable) {
        return await db!.rawQuery('''SELECT * FROM $customerTable''');
      } else if (table == sightTable) {
        return await db!.rawQuery('''SELECT * FROM $sightTable''');
      } else if (table == deviceTable) {
        return await db!.rawQuery('''SELECT * FROM $deviceTable''');
      }
    } else {
      if (table == customerTable) {
        return await db!
            .rawQuery('''SELECT * FROM $table WHERE _id = ?''', [tempId]);
      } else if (table == sightTable) {
        return await db!
            .query(table, where: "_sightId = ?", whereArgs: [tempId]);
      } else if (table == deviceTable) {
        return await db!
            .query(table, where: "_deviceId = ?", whereArgs: [tempId]);
      }
    }
    return null;
  }

  // Delete
  Future<int?> delete({required id, required table}) async {
    Database? db = await instance.db;
    if (table == customerTable) {
      return await db!.rawDelete('''DELETE FROM $table WHERE _id = ?''', [id]);
    } else if (table == sightTable) {
      return await db!
          .rawDelete('''DELETE FROM $table WHERE _sightId = ?''', [id]);
    } else if (table == deviceTable) {
      return await db!
          .rawDelete('''DELETE FROM $table WHERE _deviceId = ?''', [id]);
    }
    return null;
  }

  // Update
  Future<int> update(
      {required Map<String, dynamic> updatedRow,
      required table,
      required tempId}) async {
    Database? db = await instance.db;
    if (table == customerTable) {
      return await db!.update(
          table,
          {
            CustomerFields.columnName: updatedRow['name'],
            CustomerFields.columnAddress: updatedRow['address'],
            CustomerFields.columnEmail: updatedRow['email'],
            CustomerFields.columnPhone: updatedRow['phone'],
          },
          where: '_id = ?',
          whereArgs: [tempId]);
    } else if (table == sightTable) {
      int checked = updatedRow['checked'] == true ? 1 : 0;
      return await db!.update(
          table,
          {
            SightFields.columnSightLabel: updatedRow['label'],
            SightFields.columnSightName: updatedRow['name'],
            SightFields.columnSightAddress: updatedRow['address'],
            SightFields.columnSightEmail: updatedRow['email'],
            SightFields.columnSightPhone: updatedRow['phone'],
            SightFields.columnSightChecked: checked
          },
          where: '_sightId = ?',
          whereArgs: [tempId]);
    } else if (table == deviceTable) {
      int checked = updatedRow['checked'] == true ? 1 : 0;
      return await db!.update(
          table,
          {
            DeviceFields.columnDeviceSight: updatedRow['sight'],
            DeviceFields.columnDeviceLabel: updatedRow['label'],
            DeviceFields.columnDeviceType: updatedRow['type'],
            DeviceFields.columnDeviceImage: updatedRow['image'],
            DeviceFields.columnDeviceInformation: updatedRow['information'],
            DeviceFields.columnDeviceChecked: checked
          },
          where: '_deviceId = ?',
          whereArgs: [tempId]);
    }
    return 0;
  }
}
