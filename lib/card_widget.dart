import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CardWidget extends StatelessWidget {
  final String title;
  final double amount;
  final DateTime dateTime;

  CardWidget(this.title, this.amount, this.dateTime);

  @override
  Widget build(BuildContext context) {
    return Container(child:
      Card(child:
        Row(children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(border: Border.all(color: Colors.red, width: 3), borderRadius: BorderRadius.circular(20)),
            child: Text('\$' + amount.toString()),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: TextStyle(
                fontWeight: FontWeight.bold
              )),
              Text(dateTime.toString(), style: TextStyle(
                color: Colors.grey
              )),
            ],
          )
        ],),
      )
    );
  }
}
