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
      margin: EdgeInsets.all(15),
      elevation: 10,
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.all(10),
            child: Text('Last Week', style: TextStyle(fontSize: 20),),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: chartList
                .map((e) => Container(
                      width: 54,
                      child: Column(
                        children: [
                          FittedBox(
                            child: Text(
                              '\$' + NumberFormat("#,##0.00").format(e.amount),
                              style: TextStyle(fontSize: 11),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 5, bottom: 5),
                            width: 15,
                            height: 100,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.green, width: 1),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Container(
                              margin: EdgeInsets.only(
                                  top: _calculateMargin(e.amount, ratio)
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(2),
                                color: Colors.green,
                              ),
                            ),
                          ),
                          Text(e.date),
                        ],
                      ),
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }

  _createChartList() {
    var chartList = [];

    for (var i = 6; i >= 0; i--) {
      var date = DateTime.now().subtract(Duration(days: i));
      var dateFormat = DateFormat.yMd().format;

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
