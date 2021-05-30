import 'dart:math';

import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatefulWidget {
  final List<Transaction> transactionList;
  final Function deleteTx;
  TransactionList(this.transactionList, this.deleteTx);

  @override
  _TransactionListState createState() => _TransactionListState();
}

class _TransactionListState extends State<TransactionList> {
  Color _bgColor;

  void initState() {
    const avalableColors = [
      Colors.purple,
      Colors.red,
      Colors.black,
      Colors.blue,
    ];
    _bgColor = avalableColors[Random().nextInt(4)];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.transactionList.isEmpty
        ? Column(
            children: <Widget>[
              Text('No Transaction is added yet!'),
              Container(
                  child: Image.asset(
                'lib/assets/images/1.jpg',
                fit: BoxFit.cover,
              ))
            ],
          )
        : Container(
            height: 300,
            child: ListView.builder(
              itemBuilder: (trx, index) {
                return Card(
                  elevation: 5,
                  margin: EdgeInsets.symmetric(
                    vertical: 5,
                    horizontal: 6,
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: _bgColor,
                      radius: 30,
                      child: Padding(
                        padding: EdgeInsets.all(6),
                        child: FittedBox(
                            child: Text(
                                '\$${widget.transactionList[index].amount}')),
                      ),
                    ),
                    title: Text(
                      widget.transactionList[index].title,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                    subtitle: Text(
                      DateFormat.yMMMEd().format(
                        widget.transactionList[index].date,
                      ),
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                    trailing: MediaQuery.of(context).size.width > 360
                        ? FlatButton.icon(
                            icon: Icon(
                              Icons.delete,
                            ),
                            textColor: Colors.red,
                            label: Text('Delete'),
                            onPressed: () => widget
                                .deleteTx(widget.transactionList[index].id),
                          )
                        : IconButton(
                            icon: Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                            onPressed: () => widget
                                .deleteTx(widget.transactionList[index].id),
                          ),
                  ),
                );
              },
              itemCount: widget.transactionList.length,
            ),
          );
  }
}
