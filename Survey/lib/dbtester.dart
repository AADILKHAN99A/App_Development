import 'package:flutter/material.dart';
import 'package:survey/database_helper.dart';
import 'package:survey/datamodels.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  final dbHelper = DatabaseHelper.instance;
  @override
  void initState() {
    super.initState();
  }

  void insertData() async {
    Map<String, dynamic> row = {
      CustomerFields.columnName: "hitesh",
      CustomerFields.columnAddress: "88",
      CustomerFields.columnEmail: "hitesha@gmail.com",
      CustomerFields.columnPhone: "1234567890"
    };
    final id = await dbHelper.insert(row: row, table: customerTable);
    print(id);
    List test = [
      {
        "label": "Sight 1",
        "name": "John",
        "address": "123",
        "email": "John123@gmail.com",
        "phone": "0987654321",
        "checked": 0,
        "devices": [
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
        ]
      }
    ];
    int deviceId;
    int sightId;
    for (int i = 0; i < test.length; i++) {
      sightId =
          await dbHelper.insert(row: test[i], table: sightTable, tempId: id);
      for (int j = 0; j < test[i]['devices'].length; j++) {
        deviceId = await dbHelper.insert(
            row: test[i]['devices'][j], table: deviceTable, tempId: sightId);
        print("Device ID $deviceId");
      }
      print("Sight ID $sightId");
    }
  }

  void queryTable() async {
    var allRows = await dbHelper.queryAllRow(table: deviceTable);
    allRows!.forEach((row) {
      print(row);
    });
  }

  void querySpecific() async {
    var allRows = await dbHelper.queryAllRow(table: deviceTable, tempId: 3);
    allRows!.forEach((row) {
      print(row);
    });
  }

  void delete() async {
    var id = await dbHelper.delete(id: 1, table: deviceTable);
    print(id);
  }

  void update() async {
    var row = await dbHelper.update(updatedRow: {
      "sight": "Sight 1",
      "label": "Heater information",
      "type": "panel",
      "image": "Aadilkhan.jpg",
      "information": "",
      "checked": true
    }, table: deviceTable, tempId: 3);
    print(row);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(onPressed: insertData, child: const Text("Insert")),
          ElevatedButton(onPressed: queryTable, child: const Text("Query")),
          ElevatedButton(onPressed: delete, child: const Text("Delete")),
          ElevatedButton(onPressed: update, child: const Text("Update")),
          ElevatedButton(
              onPressed: querySpecific, child: const Text("SpecificQuery")),
        ],
      ),
    ));
  }
}
