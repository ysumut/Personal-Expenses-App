import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';
import '../models/chart_bar.dart';

class ChartScreen extends StatelessWidget {
  final List<Transaction> _lastWeekTransactions;

  ChartScreen(this._lastWeekTransactions);

  @override
  Widget build(BuildContext context) {
    List<dynamic> chartList = _createChartList();
    double maxDailyAmount = chartList
        .reduce((a, b) => a.amount > b.amount ? a : b)
        .amount; // find max daily amount

    maxDailyAmount = maxDailyAmount == 0 ? 100 : maxDailyAmount;
    double ratio = 100 / maxDailyAmount; // find ratio

    return Card(
        elevation: 10,
        child: LayoutBuilder(builder: (ctx, constraints) {
          return Container(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.all(constraints.maxHeight * 0.05),
                  height: constraints.maxHeight * 0.2,
                  child: Text(
                    'Last Week',
                    style: TextStyle(fontSize: constraints.maxHeight * 0.12),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: chartList
                      .map((e) => Container(
                            width: 54,
                            child: Column(
                              children: [
                                Container(
                                  height: constraints.maxHeight * 0.1,
                                  child: FittedBox(
                                    child: Text(
                                      '\$' +
                                          NumberFormat("#,##0")
                                              .format(e.amount),
                                      style: TextStyle(fontSize: 11),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 10,
                                  height: constraints.maxHeight * 0.5,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.green, width: 1),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Container(
                                    margin: EdgeInsets.only(
                                        top: _calculateMargin(e.amount, ratio)),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(2),
                                      color: Colors.green,
                                    ),
                                  ),
                                ),
                                Container(
                                  height: constraints.maxHeight * 0.1,
                                  child: FittedBox(child: Text(e.date)),
                                ),
                              ],
                            ),
                          ))
                      .toList(),
                ),
              ],
            ),
          );
        }));
  }

  _createChartList() {
    var chartList = [];
    var dateFormat = DateFormat.yMd().format;

    for (var i = 6; i >= 0; i--) {
      var date = DateTime.now().subtract(Duration(days: i));

      double totalAmount = 0;
      _lastWeekTransactions.forEach((e) {
        if (dateFormat(e.dateTime) == dateFormat(date)) totalAmount += e.amount;
      }); // sum daily amount list

      chartList.add(
          ChartBar(amount: totalAmount, date: DateFormat.E().format(date)));
    }

    return chartList;
  }

  double _calculateMargin(amount, ratio) {
    double result = (100 - (amount * ratio)) as double;
    return (result < 0) ? 0 : result;
  }
}
