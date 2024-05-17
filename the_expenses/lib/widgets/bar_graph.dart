import 'package:flutter/Material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:the_expenses/screens/home_screen/models/bar_data.dart';
import 'package:the_expenses/utils/color_constants.dart';

class CustomBarGraph extends StatelessWidget {
  final double? maxY;
  final double sunAmount;
  final double monAmount;
  final double tueAmount;
  final double wedAmount;
  final double thuAmount;
  final double friAmount;
  final double satAmount;

  const CustomBarGraph(
      {super.key,
      this.maxY,
      required this.sunAmount,
      required this.monAmount,
      required this.tueAmount,
      required this.wedAmount,
      required this.thuAmount,
      required this.friAmount,
      required this.satAmount});

  @override
  Widget build(BuildContext context) {
    BarData barData = BarData(
        sunAmount: sunAmount,
        monAmount: monAmount,
        tueAmount: tueAmount,
        wedAmount: wedAmount,
        thuAmount: thuAmount,
        friAmount: friAmount,
        satAmount: satAmount);
    barData.initializeBarData();
    return BarChart(BarChartData(
        maxY: maxY,
        minY: 0,
        gridData: const FlGridData(show: false),
        titlesData: FlTitlesData(
            show: true,
            topTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            leftTitles:
                const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles:
                const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                    reservedSize: 24,
                    showTitles: true,
                    getTitlesWidget: gotBottomTitles))),
        borderData: FlBorderData(show: false),
        barGroups: barData.barData
            .map((individualBar) =>
                BarChartGroupData(x: individualBar.x, barRods: [
                  BarChartRodData(
                      toY: individualBar.y,
                      color: const Color(darkBlue),
                      width: 25,
                      borderRadius: BorderRadius.circular(4),
                      backDrawRodData: BackgroundBarChartRodData(
                          show: true, toY: maxY, color: Colors.grey[200]))
                ]))
            .toList()));
  }

  Widget gotBottomTitles(double value, TitleMeta meta) {
    const TextStyle style = TextStyle(
        color: Color(darkBlue), fontWeight: FontWeight.bold, fontSize: 14);
    Widget text;
    switch (value.toInt()) {
      case 0:
        text = const Text(
          'S',
          style: style,
        );
        break;

      case 1:
        text = const Text(
          'M',
          style: style,
        );
        break;

      case 2:
        text = const Text(
          'T',
          style: style,
        );
        break;

      case 3:
        text = const Text(
          'W',
          style: style,
        );
        break;
      case 4:
        text = const Text(
          'T',
          style: style,
        );
        break;
      case 5:
        text = const Text(
          'F',
          style: style,
        );
        break;
      case 6:
        text = const Text(
          'S',
          style: style,
        );
        break;
      default:
        text = const Text(
          '',
          style: style,
        );
        break;
    }

    return SideTitleWidget(axisSide: meta.axisSide, child: text);
  }
}
