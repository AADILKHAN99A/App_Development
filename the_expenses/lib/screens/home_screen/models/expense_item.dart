import 'package:intl/intl.dart';
import 'package:the_expenses/screens/signup_screen/models/signup_model.dart';

class ExpenseItem {
  final int? id;

  final int foreignId;
  final String name;
  final String amount;

  final DateTime dateTime;

  ExpenseItem(
      {this.id,
      required this.foreignId,
      required this.name,
      required this.amount,
      required this.dateTime});

  copy(
          {int? id,
          int? foreignId,
          String? name,
          String? amount,
          DateTime? dateTime}) =>
      ExpenseItem(
          id: id ?? this.id,
          foreignId: foreignId ?? this.foreignId,
          name: name ?? this.name,
          amount: amount ?? this.amount,
          dateTime: dateTime ?? this.dateTime);

  toMap() => {
        ExpenseTableFields.columnId: id,
        ExpenseTableFields.columnForeignKeyId: foreignId,
        ExpenseTableFields.columnDate:
            DateFormat('yyyy-MM-dd').format(dateTime),
        ExpenseTableFields.columnName: name,
        ExpenseTableFields.columnAmount: amount
      };

  factory ExpenseItem.fromMap(Map<String, dynamic> data) => ExpenseItem(
        id: data[ExpenseTableFields.columnId],
        foreignId: data[ExpenseTableFields.columnForeignKeyId],
        dateTime:
            DateFormat('yyyy-MM-dd').parse(data[ExpenseTableFields.columnDate]),
        name: data[ExpenseTableFields.columnName],
        amount: data[ExpenseTableFields.columnAmount].toString(),
      );
}

class ExpenseTableFields {
  List<String> values = [
    columnId,
    columnForeignKeyId,
    columnDate,
    columnName,
    columnAmount
  ];

  static const String expenseTable = 'ExpenseTable';
  static const String columnId = '_id';
  static const String idType = 'INTEGER PRIMARY KEY';

  static const String columnDate = 'date';
  static const String dateType = 'DATE NOT NULL';

  static const String columnName = 'name';
  static const String nameType = 'TEXT NOT NULL';

  static const String columnAmount = 'amount';
  static const String amountType = 'INTEGER NOT NULL';

  static const String columnForeignKeyId = 'id';
  static const String foreignKeyIdType = 'INTEGER';

  static const String foreignKeyCondition =
      'FOREIGN KEY($columnForeignKeyId) REFERENCES ${UserTableFields.userTable}(${UserTableFields.columnID}) ON DELETE CASCADE';
}
