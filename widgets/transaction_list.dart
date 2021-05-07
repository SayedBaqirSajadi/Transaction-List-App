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
                  elevation: 5,
                  margin: EdgeInsets.symmetric(
                    vertical: 5,
                    horizontal: 6,
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      child: Padding(
                        padding: EdgeInsets.all(6),
                        child: FittedBox(
                            child: Text('\$${transactionList[index].amount}')),
                      ),
                    ),
                    title: Text(
                      transactionList[index].title,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                    subtitle: Text(
                      DateFormat.yMMMEd().format(
                        transactionList[index].date,
                      ),
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                );
              },
              itemCount: transactionList.length,
            ),
          );
  }
}
