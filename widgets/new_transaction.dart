import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function newtrx;
  NewTransaction(this.newtrx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _selectedDate;

  void _submitData() {
    final submitedTitle = _titleController.text;
    final submitedAmount = double.parse(_amountController.text);

    if (submitedTitle.isEmpty || submitedAmount <= 0 || _selectedDate == null) {
      return;
    }

    widget.newtrx(submitedTitle, submitedAmount, _selectedDate);
  }

  void datePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2020),
            lastDate: DateTime.now())
        .then((datePicked) {
      if (datePicked == null) {
        return;
      }
      setState(() {
        _selectedDate = datePicked;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          TextField(
            decoration: InputDecoration(labelText: 'Title'),
            controller: _titleController,
            onSubmitted: (_) => _submitData(),
          ),
          TextField(
            decoration: InputDecoration(labelText: 'Amount'),
            controller: _amountController,
            keyboardType: TextInputType.number,
            onSubmitted: (_) => _submitData(),
          ),
          Container(
            height: 50,
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    _selectedDate == null
                        ? 'No date choicen!'
                        : 'Date Selected: ${DateFormat.yMEd().format(_selectedDate)}',
                  ),
                ),
                FlatButton(onPressed: datePicker, child: Text('Select date'))
              ],
            ),
          ),
          RaisedButton(
            onPressed: () => _submitData,
            child: Text(
              'Add Transaction',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            color: Theme.of(context).primaryColor,
            textColor: Theme.of(context).textTheme.button.color,
          ),
        ],
      ),
    );
  }
}
