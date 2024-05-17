import 'package:the_expenses/database/database_helper.dart';
import 'package:the_expenses/screens/signup_screen/models/signup_model.dart';

import '../models/expense_item.dart';

class ExpenseDatabaseHelper {
  DatabaseHelper helper = DatabaseHelper.instance;

  Future<ExpenseItem?> saveData(ExpenseItem item) async {
    final response = await helper.insertExpense(item: item);
    return response;
  }

  Future<List<ExpenseItem>> readData({required int id}) async {
    List<ExpenseItem> list = await helper.fetchUserExpenses(id: id);
    return list;
  }

  Future<int?> deleteData({required ExpenseItem item}) async {
    final id = await helper.deleteExpense(id: item.id!);

    return id;
  }

  Future<int> editData({required ExpenseItem item}) async {
    final int id = await helper.editExpense(item: item);
    return id;
  }
}
