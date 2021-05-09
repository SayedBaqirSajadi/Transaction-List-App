import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './widgets/chart.dart';
import './widgets/transaction_list.dart';
import './widgets/new_transaction.dart';

import './models/transaction.dart';

void main() {
  // SystemChrome.setPreferredOrientations(
  //   [
  //     DeviceOrientation.portraitUp,
  //     DeviceOrientation.portraitUp,
  //   ],
  // );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'New Transaction',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.amber,
        textTheme: ThemeData.light().textTheme.copyWith(
                title: TextStyle(
              fontFamily: 'Raleway',
              fontSize: 20,
              fontWeight: FontWeight.bold,
            )),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
                title: TextStyle(
                  fontFamily: 'Raleway',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                button: TextStyle(
                  color: Colors.white,
                ),
              ),
        ),
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Transaction> _transaction = [
    Transaction(
      id: 'T1',
      title: 'Mobile',
      amount: 120.7,
      date: DateTime.now(),
    ),
    Transaction(
      id: 'T2',
      title: 'Computer',
      amount: 820.7,
      date: DateTime.now(),
    ),
    Transaction(
      id: 'T3',
      title: 'Telvesion',
      amount: 520.7,
      date: DateTime.now(),
    ),
  ];

  void _addTransaction(String newTitle, double newAmoun, DateTime dateChoicen) {
    final newTx = Transaction(
        id: DateTime.now().toString(),
        title: newTitle,
        amount: newAmoun,
        date: dateChoicen);

    setState(() {
      _transaction.add(newTx);
    });
    Navigator.of(context).pop();
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return GestureDetector(
            onTap: () {},
            child: NewTransaction(_addTransaction),
            behavior: HitTestBehavior.opaque,
          );
        });
  }

  List<Transaction> get _recentTransaction {
    return _transaction.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          Duration(
            days: 7,
          ),
        ),
      );
    }).toList();
  }

  void deleteTransaction(String id) {
    setState(() {
      _transaction.removeWhere(
        (tx) => tx.id == id,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      title: Text('Transaction'),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () => _startAddNewTransaction(context),
        )
      ],
    );
    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
                height: (MediaQuery.of(context).size.height * 0.4 -
                    appBar.preferredSize.height -
                    MediaQuery.of(context).padding.top),
                child: Chart(_recentTransaction)),
            Container(
                height: (MediaQuery.of(context).size.height * 0.6 -
                    appBar.preferredSize.height -
                    MediaQuery.of(context).padding.top),
                child: TransactionList(_transaction, deleteTransaction))
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
        ),
        onPressed: () => _startAddNewTransaction(context),
      ),
    );
  }
}
