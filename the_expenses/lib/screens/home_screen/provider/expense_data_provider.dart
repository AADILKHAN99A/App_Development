import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:the_expenses/screens/home_screen/provider/expense_database_helper.dart';
import 'package:the_expenses/screens/signup_screen/models/signup_model.dart';
import 'package:the_expenses/utils/custom_toast.dart';

import '../models/expense_item.dart';

class ExpenseDataProvider extends ChangeNotifier {
// list of all expenses

  List<ExpenseItem> allExpensesList = [];

// get expense list

  getAllExpenseList({required SignUpModel model}) async {
    await ExpenseDatabaseHelper().readData(id: model.id!).then((list) {
      allExpensesList = list;
    });
    notifyListeners();
  }

//add new expense

  void addNewExpense(ExpenseItem item) async {
    await ExpenseDatabaseHelper().saveData(item).then((item) {
      if (item != null) {
        allExpensesList.add(item);
      } else {
        commonToast("Something Wrong!");
      }
    });
    notifyListeners();
  }

// delete expense

  void deleteExpense(ExpenseItem item) async {
    await ExpenseDatabaseHelper().deleteData(item: item).then((value) {
      if (value != null) {
        allExpensesList.remove(item);
      } else {
        commonToast("Something Went Wrong!");
      }
    });

    notifyListeners();
  }

  void editExpense(SignUpModel model, ExpenseItem item) async {
    // print("method called");
    await ExpenseDatabaseHelper().editData(item: item).then((value) {
      if (value != 0) {
        getAllExpenseList(model: model);
      } else {
        commonToast("Something Wrong!");
      }
    });
  }

// get weekday

  String getDayName(DateTime dateTime) {
    switch (dateTime.weekday) {
      case 1:
        return 'Mon';
      case 2:
        return 'Tue';
      case 3:
        return 'Wed';
      case 4:
        return 'Thu';
      case 5:
        return 'Fri';
      case 6:
        return 'Sat';
      case 7:
        return 'Sun';

      default:
        return '';
    }
  }

// get the date for the start of the week

  DateTime startOfWeek() {
    DateTime? startOfWeekDate;
    DateTime today = DateTime.now();

    for (int i = 0; i < 7; i++) {
      if (getDayName(today.subtract(Duration(days: i))) == 'Sun') {
        startOfWeekDate = today.subtract(Duration(days: i));
      }
    }
    return startOfWeekDate!;
  }

// daily expense summary

  Map<String, double> calculateDailyExpnesnsesSummary() {
    Map<String, double> dailyExpenseSummary = {};

    for (var expense in allExpensesList) {
      String date = DateFormat('yyyyMMdd').format(expense.dateTime);
      double amount = double.parse(expense.amount);

      if (dailyExpenseSummary.containsKey(date)) {
        double currentAmount = dailyExpenseSummary[date]!;
        currentAmount += amount;
        dailyExpenseSummary[date] = currentAmount;
      } else {
        dailyExpenseSummary.addAll({date: amount});
      }
    }
    return dailyExpenseSummary;
  }




}
