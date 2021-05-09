import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactionList;
  final Function deleteTx;
  TransactionList(this.transactionList, this.deleteTx);

  @override
  Widget build(BuildContext context) {
    return transactionList.isEmpty
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
                    trailing: IconButton(
                      icon: Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                      onPressed: () => deleteTx(transactionList[index].id),
                    ),
                  ),
                );
              },
              itemCount: transactionList.length,
            ),
          );
  }
}
