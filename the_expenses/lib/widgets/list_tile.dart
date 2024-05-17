import 'package:flutter/Material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:the_expenses/screens/home_screen/models/expense_item.dart';
import 'package:the_expenses/utils/color_constants.dart';

class CustomExpenseTile extends StatefulWidget {
  final ExpenseItem item;
  void Function(BuildContext)? deleteTap;
  void Function(BuildContext)? editTap;

  CustomExpenseTile(
      {super.key,
      required this.item,
      required this.deleteTap,
      required this.editTap});

  @override
  State<CustomExpenseTile> createState() => _CustomExpenseTileState();
}

class _CustomExpenseTileState extends State<CustomExpenseTile> {
  @override
  Widget build(BuildContext context) {
    String date = DateFormat('dd/MM/yyyy').format(widget.item.dateTime);
    return Slidable(
      endActionPane: ActionPane(motion: const StretchMotion(), children: [
        SlidableAction(
          onPressed: widget.editTap,
          icon: Icons.edit,
          backgroundColor: const Color(darkBlue),
          borderRadius: BorderRadius.circular(4),
        ),
        SlidableAction(
          onPressed: widget.deleteTap,
          icon: Icons.delete,
          backgroundColor: Colors.red,
          borderRadius: BorderRadius.circular(4),
        )
      ]),
      child: ListTile(
        title: Text(widget.item.name),
        subtitle: Text(date),
        trailing: Text('₹${widget.item.amount}'),
      ),
    );
  }
}
