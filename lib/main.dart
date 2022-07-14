import 'dart:math';

import 'package:expenses/components/chart.dart';
import 'package:expenses/components/transaction_form.dart';
import 'package:flutter/material.dart';

import 'components/transaction_list.dart';
import 'models/transaction.dart';

main() => runApp(ExpensesApp());

class ExpensesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ThemeData tema = ThemeData();
    return MaterialApp(
        home: MyHomePage(),
        theme: tema.copyWith(
          colorScheme: tema.colorScheme.copyWith(
            primary: Colors.blue,
            secondary: Colors.grey,
          ),
          textTheme: tema.textTheme.copyWith(
              headline6: TextStyle(
                fontFamily: 'JetBrainsMono',
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              button:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          appBarTheme: AppBarTheme(
            titleTextStyle: TextStyle(
              fontFamily: 'JetBrainsMono',
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
        ));
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _transcations = [];
  bool _showChart = false;

  List<Transaction> get _recentTransactions {
    return _transcations.where((tr) {
      return tr.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  _openTransactionFormModal(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (ctx) {
          return TransactionForm(_addTransaction);
        });
  }

  _addTransaction(String title, double value, DateTime date) {
    final newTransaction = Transaction(
      id: Random().nextDouble().toString(),
      title: title,
      value: value,
      date: date,
    );

    setState(() {
      _transcations.add(newTransaction);
    });

    Navigator.of(context).pop();
  }

  _deleteTransaction(String id) {
    setState(() {
      _transcations.removeWhere((tr) => tr.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    final appBar = AppBar(
      title: Text(
        "ForEx",
      ),
      actions: [
        if(isLandscape) IconButton(
          onPressed: () {
            setState(() {
              _showChart = !_showChart;
            });
          },
          icon: Icon(_showChart ? Icons.list : Icons.show_chart),
        ),
        IconButton(
          onPressed: () => _openTransactionFormModal(context),
          icon: Icon(Icons.add),
        ),
      ],
    );

    final availableHeight = MediaQuery.of(context).size.height -
        appBar.preferredSize.height -
        MediaQuery.of(context).padding.top;

    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              if (_showChart || !isLandscape)
                Container(
                  height: availableHeight * (isLandscape ? 0.70 : 0.25),
                  child: Chart(_recentTransactions),
                ),
              if (!_showChart || !isLandscape)
                Container(
                  height: availableHeight * 0.75,
                  child: TransactionList(_transcations, _deleteTransaction),
                ),
            ]),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _openTransactionFormModal(context),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
