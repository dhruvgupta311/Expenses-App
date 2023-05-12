import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatefulWidget{

  @override
  _TransactionListState createState() => _TransactionListState();
}

class _TransactionListState extends State<TransactionList>{
  final List<Transaction> _userTransactions=[
    Transaction(
        id: 't1', title: 'New Shoes', amount: 65.9, date: DateTime.now()),
    Transaction(
        id: 't2', title: 'Weekly Groceries', amount: 18, date: DateTime.now()),
  ];
  @override
  Widget build(BuildContext context){
    return   Column(
            children: _userTransactions.map((tx) {
              return Card(
                child: Row(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 5,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.lightBlue[50],
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Color.fromARGB(255, 0, 5, 9),
                          width: 2,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      padding: EdgeInsets.all(10),
                        child: Text(
                          '\$${tx.amount}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.black,
                          ),
                        ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          tx.title,
                          style: TextStyle(
                            fontSize: 18,
                          fontWeight:FontWeight.bold),
                          ),
                        Text(
                          DateFormat("yyyy/MM/dd").format(tx.date),
                          style: TextStyle(
                            color: Colors.indigo,
                            ),
                        ),
                      ],
                    )
                  ],
                ),
              );
            }).toList(),
          );
  }
}