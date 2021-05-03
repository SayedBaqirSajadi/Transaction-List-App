import 'package:flutter/material.dart';

class NewTransaction extends StatefulWidget {
  final Function newtrx;
  NewTransaction(this.newtrx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();

  final amountController = TextEditingController();

  void submitData() {
    final submitedTitle = titleController.text;
    final submitedAmount = double.parse(amountController.text);

    if (submitedTitle.isEmpty || submitedAmount <= 0) {
      return;
    }

    widget.newtrx(
      submitedTitle,
      submitedAmount,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          TextField(
            decoration: InputDecoration(labelText: 'Title'),
            controller: titleController,
            onSubmitted: (_) => submitData(),
          ),
          TextField(
            decoration: InputDecoration(labelText: 'Amount'),
            controller: amountController,
            keyboardType: TextInputType.number,
            onSubmitted: (_) => submitData(),
          ),
          FlatButton(
            onPressed: () => submitData,
            child: Text(
              'Add Transaction',
              style: TextStyle(
                color: Colors.blue,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
