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
            button: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold
            )
          ),
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
  final List<Transaction> _transcations = [
    Transaction(
      id: "t0",
      title: "Conta Antiga",
      value: 500.00,
      date: DateTime.now().subtract(Duration(days: 1)),
    ),
    Transaction(
      id: "t1",
      title: "Air Jordan",
      value: 150.00,
      date: DateTime.now().subtract(Duration(days: 2)),
    ),
    Transaction(
      id: "t2",
      title: "Conta Internet",
      value: 129.90,
      date: DateTime.now().subtract(Duration(days: 3)),
    ),
    Transaction(
      id: "t3",
      title: "Conta Energia",
      value: 118.90,
      date: DateTime.now().subtract(Duration(days: 4)),
    ),
    Transaction(
      id: "t4",
      title: "Gás",
      value: 120.90,
      date: DateTime.now().subtract(Duration(days: 5)),
    ),
    Transaction(
      id: "t5",
      title: "Parcela MT-03",
      value: 700.00,
      date: DateTime.now().subtract(Duration(days: 6)),
    ),
    Transaction(
      id: "t6",
      title: "Seguro",
      value: 148.80,
      date: DateTime.now().subtract(Duration(days: 7)),
    ),
    Transaction(
      id: "t7",
      title: "Curso",
      value: 49.80,
      date: DateTime.now(),
    ),
  ];

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

  _addTransaction(String title, double value) {
    final newTransaction = Transaction(
      id: Random().nextDouble().toString(),
      title: title,
      value: value,
      date: DateTime.now(),
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
    return Scaffold(
      appBar: AppBar(
        title: Text("ForEx"),
        actions: [
          IconButton(
              onPressed: () => _openTransactionFormModal(context),
              icon: Icon(Icons.add))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Chart(_recentTransactions),
              TransactionList(_transcations),
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
