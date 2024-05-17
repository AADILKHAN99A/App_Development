import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_expenses/screens/home_screen/models/expense_item.dart';
import 'package:the_expenses/screens/home_screen/provider/expense_data_provider.dart';
import 'package:the_expenses/screens/signup_screen/models/signup_model.dart';
import 'package:the_expenses/widgets/expense_summary.dart';
import 'package:the_expenses/widgets/list_tile.dart';
import '../../utils/color_constants.dart';
import '../../widgets/custom_elevated_button.dart';

class HomeScreen extends StatefulWidget {
  final Map args;

  const HomeScreen({super.key, required this.args});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController amountController = TextEditingController();

  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if (kDebugMode) {
      print("arguments: ${widget.args}");
    }
    refreshList();
  }

  refreshList() {
    Provider.of<ExpenseDataProvider>(context, listen: false)
        .getAllExpenseList(model: widget.args['data'] as SignUpModel);
  }

  void save() {
    if (nameController.text.isNotEmpty && amountController.text.isNotEmpty) {
      ExpenseItem item = ExpenseItem(
          name: nameController.text,
          amount: amountController.text,
          dateTime: DateTime.now(),
          foreignId: widget.args['data'].id);
      Provider.of<ExpenseDataProvider>(context, listen: false)
          .addNewExpense(item);
      clear();
    }

    Navigator.pop(context);
  }

  void delete(ExpenseItem item) {
    Provider.of<ExpenseDataProvider>(context, listen: false)
        .deleteExpense(item);
  }

  void edit(ExpenseItem item) {
    if (nameController.text.isNotEmpty && amountController.text.isNotEmpty) {
      ExpenseItem newItem = ExpenseItem(
          id: item.id,
          name: nameController.text,
          amount: amountController.text,
          dateTime: item.dateTime,
          foreignId: item.foreignId);
      Provider.of<ExpenseDataProvider>(context, listen: false)
          .editExpense(widget.args['data'], newItem);
      clear();
    }
    Navigator.pop(context);
  }

  void clear() {
    nameController.clear();
    amountController.clear();
  }

  void editExpense(ExpenseItem item) {
    nameController.text = item.name;
    amountController.text = item.amount;
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => AlertDialog(
              title: const Center(child: Text("Edit Expense")),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: nameController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.short_text_rounded),
                      hintText: "Description",
                      fillColor: Colors.grey[300],
                      filled: true,
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                      controller: amountController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.currency_rupee),
                        hintText: "Amount",
                        fillColor: Colors.grey[300],
                        filled: true,
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide.none),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide.none),
                      ))
                ],
              ),
              actions: [
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  width: 100,
                  child: CustomElevatedButton(
                    onPressed: () => edit(item),
                    text: "Submit",
                    buttonStyle: ElevatedButton.styleFrom(
                        backgroundColor: const Color(darkBlue)),
                    buttonTextStyle: const TextStyle(color: Colors.white),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  width: 100,
                  child: CustomElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    text: "Cancel",
                    buttonStyle: ElevatedButton.styleFrom(
                        backgroundColor: const Color(darkBlue)),
                    buttonTextStyle: const TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ));
  }

  void addNewExpense() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => AlertDialog(
              title: const Center(child: Text("Add new Expense")),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: nameController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.short_text_rounded),
                      hintText: "Description",
                      fillColor: Colors.grey[300],
                      filled: true,
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                      controller: amountController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.currency_rupee),
                        hintText: "Amount",
                        fillColor: Colors.grey[300],
                        filled: true,
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide.none),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide.none),
                      ))
                ],
              ),
              actions: [
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  width: 100,
                  child: CustomElevatedButton(
                    onPressed: save,
                    text: "Submit",
                    buttonStyle: ElevatedButton.styleFrom(
                        backgroundColor: const Color(darkBlue)),
                    buttonTextStyle: const TextStyle(color: Colors.white),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  width: 100,
                  child: CustomElevatedButton(
                    onPressed: () {
                      clear();
                      Navigator.pop(context);
                    },
                    text: "Cancel",
                    buttonStyle: ElevatedButton.styleFrom(
                        backgroundColor: const Color(darkBlue)),
                    buttonTextStyle: const TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ExpenseDataProvider>(builder: (context, provider, child) {
      return SafeArea(
        child: Scaffold(
            resizeToAvoidBottomInset: true,
            floatingActionButton: FloatingActionButton(
              onPressed: addNewExpense,
              backgroundColor: const Color(darkBlue),
              child: const Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
            // appBar: AppBar(),
            body: ListView(
              children: [
                const SizedBox(
                  height: 20,
                ),
                ExpenseSummary(startOfWeek: provider.startOfWeek()),
                const SizedBox(
                  height: 20,
                ),
                provider.allExpensesList.isEmpty
                    ? const Center(
                        child: Text(
                          "Press + Button To Add Expense",
                          style: TextStyle(color: Color(darkBlue)),
                        ),
                      )
                    : ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: provider.allExpensesList.length,
                        itemBuilder: (BuildContext context, int index) =>
                            CustomExpenseTile(
                              item: provider.allExpensesList[index],
                              deleteTap: (context) =>
                                  delete(provider.allExpensesList[index]),
                              editTap: (context) =>
                                  editExpense(provider.allExpensesList[index]),
                            )),
              ],
            )),
      );
    });
  }
}
