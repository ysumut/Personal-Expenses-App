import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';
import '../models/chart_column.dart';

class ChartScreen extends StatelessWidget {
  final List<Transaction> _txList;

  ChartScreen(this._txList);

  @override
  Widget build(BuildContext context) {
    List<dynamic> chartList = _createChartList();
    double maxDailyAmount = chartList.map((e) => e.amount).reduce((a, b) => a > b ? a : b); // find max daily amount
    double ratio = 100 / maxDailyAmount; // find ratio

    return Card(
      margin: EdgeInsets.all(15),
      elevation: 10,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: chartList
            .map((e) => Column(
                  children: [
                    Text(e.amount.toStringAsFixed(2)),
                    Container(
                      margin: EdgeInsets.only(top: 5, bottom: 5),
                      width: 20,
                      height: e.amount * ratio,
                      color: Colors.green,
                    ),
                    Text(e.date),
                  ],
                ))
            .toList(),
      ),
    );
  }

  _createChartList() {
    var chartList = [];

    for (var i = 6; i >= 0; i--) {
      var date = DateTime.now().subtract(Duration(days: i));
      var dateFormat = DateFormat.yMd().format;

      double totalAmount = _txList
          .map((e) => (dateFormat(e.dateTime) == dateFormat(date)) ? e.amount : 0) // find daily amount list by datetime
          .fold(0, (previousValue, element) => previousValue + element); // sum daily amount list

      chartList.add(ChartColumn(
          amount: totalAmount,
          date: DateFormat.Md().format(date)
      ));
    }

    return chartList;
  }
}
