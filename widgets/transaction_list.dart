import 'package:flutter/material.dart';
import '../models/transaction.dart';

import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactionList;
  TransactionList(this.transactionList);

  @override
  Widget build(BuildContext context) {
    return transactionList.isEmpty
        ? Column(
            children: <Widget>[
              Text('No Transaction is added yet!'),
              Container(
                  height: 200,
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
                  child: Row(
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                          width: 2,
                          color: Theme.of(context).primaryColor,
                        )),
                        child: Card(
                          child: Text(
                            transactionList[index].amount.toStringAsFixed(2),
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Card(
                            child: Text(
                              transactionList[index].title,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                          ),
                          Card(
                            child: Text(DateFormat.yMMMMd()
                                .format(transactionList[index].date)),
                          ),
                        ],
                      )
                    ],
                  ),
                );
              },
              itemCount: transactionList.length,
            ),
          );
  }
}
