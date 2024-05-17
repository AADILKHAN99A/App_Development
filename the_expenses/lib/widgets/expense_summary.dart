import 'package:flutter/Material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:the_expenses/screens/home_screen/provider/expense_data_provider.dart';
import 'package:the_expenses/widgets/bar_graph.dart';

class ExpenseSummary extends StatelessWidget {
  final DateTime startOfWeek;

  const ExpenseSummary({super.key, required this.startOfWeek});

  double calculateMax(
      ExpenseDataProvider value,
      String sunday,
      String monday,
      String tuesday,
      String wednesday,
      String thursday,
      String friday,
      String saturday) {
    double? max = 100;

    List<double> values = [
      value.calculateDailyExpnesnsesSummary()[sunday] ?? 0,
      value.calculateDailyExpnesnsesSummary()[monday] ?? 0,
      value.calculateDailyExpnesnsesSummary()[tuesday] ?? 0,
      value.calculateDailyExpnesnsesSummary()[wednesday] ?? 0,
      value.calculateDailyExpnesnsesSummary()[thursday] ?? 0,
      value.calculateDailyExpnesnsesSummary()[friday] ?? 0,
      value.calculateDailyExpnesnsesSummary()[saturday] ?? 0,
    ];

    values.sort();

    max = values.last * 1.1;
    return max == 0 ? 100 : max;
  }

  String calculateWeekTotal(
      ExpenseDataProvider value,
      String sunday,
      String monday,
      String tuesday,
      String wednesday,
      String thursday,
      String friday,
      String saturday) {
    List<double> values = [
      value.calculateDailyExpnesnsesSummary()[sunday] ?? 0,
      value.calculateDailyExpnesnsesSummary()[monday] ?? 0,
      value.calculateDailyExpnesnsesSummary()[tuesday] ?? 0,
      value.calculateDailyExpnesnsesSummary()[wednesday] ?? 0,
      value.calculateDailyExpnesnsesSummary()[thursday] ?? 0,
      value.calculateDailyExpnesnsesSummary()[friday] ?? 0,
      value.calculateDailyExpnesnsesSummary()[saturday] ?? 0,
    ];

    double total = 0;
    for (int i = 0; i < values.length; i++) {
      total += values[i];
    }

    return total.toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    String sunday = DateFormat('yyyyMMdd')
        .format(startOfWeek.add(const Duration(days: 0)))
        .toString();

    String monday = DateFormat('yyyyMMdd')
        .format(startOfWeek.add(const Duration(days: 1)))
        .toString();

    String tuesday = DateFormat('yyyyMMdd')
        .format(startOfWeek.add(const Duration(days: 2)))
        .toString();

    String wednesday = DateFormat('yyyyMMdd')
        .format(startOfWeek.add(const Duration(days: 3)))
        .toString();

    String thursday = DateFormat('yyyyMMdd')
        .format(startOfWeek.add(const Duration(days: 4)))
        .toString();

    String friday = DateFormat('yyyyMMdd')
        .format(startOfWeek.add(const Duration(days: 5)))
        .toString();

    String saturday = DateFormat('yyyyMMdd')
        .format(startOfWeek.add(const Duration(days: 6)))
        .toString();

    return Consumer<ExpenseDataProvider>(
        builder: (context, provider, child) => Column(
              children: [
                Row(
                  children: [
                    const SizedBox(
                      width: 20,
                    ),
                    const Text("Week Total: "),
                    Text(
                        "₹${calculateWeekTotal(provider, sunday, monday, tuesday, wednesday, thursday, friday, saturday)}")
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                SizedBox(
                  height: 200,
                  child: CustomBarGraph(
                      maxY: calculateMax(provider, sunday, monday, tuesday,
                          wednesday, thursday, friday, saturday),
                      sunAmount:
                          provider.calculateDailyExpnesnsesSummary()[sunday] ??
                              0,
                      monAmount:
                          provider.calculateDailyExpnesnsesSummary()[monday] ??
                              0,
                      tueAmount:
                          provider.calculateDailyExpnesnsesSummary()[tuesday] ??
                              0,
                      wedAmount:
                          provider.calculateDailyExpnesnsesSummary()[wednesday] ??
                              0,
                      thuAmount:
                          provider.calculateDailyExpnesnsesSummary()[thursday] ??
                              0,
                      friAmount:
                          provider.calculateDailyExpnesnsesSummary()[friday] ??
                              0,
                      satAmount:
                          provider.calculateDailyExpnesnsesSummary()[saturday] ?? 0),
                ),
              ],
            ));
  }
}
