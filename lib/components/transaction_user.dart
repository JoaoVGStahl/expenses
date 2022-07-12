import 'dart:math';

import 'package:expenses/components/transaction_form.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../models/transaction.dart';
import 'package:expenses/components/transaction_list.dart';

class TransactionUser extends StatefulWidget {
  const TransactionUser({Key? key}) : super(key: key);

  @override
  State<TransactionUser> createState() => _TransactionUserState();
}

class _TransactionUserState extends State<TransactionUser> {
  final _transcations = [
    Transaction(
      id: "t1",
      title: "Air Jordan",
      value: 150.00,
      date: DateTime.now(),
    ),
    Transaction(
      id: "t2",
      title: "Conta Internet",
      value: 129.90,
      date: DateTime.now(),
    ),
    Transaction(
      id: "t3",
      title: "Conta Internet",
      value: 129.90,
      date: DateTime.now(),
    ),
    Transaction(
      id: "t4",
      title: "Conta Internet",
      value: 129.90,
      date: DateTime.now(),
    ),
    Transaction(
      id: "t5",
      title: "Conta Internet",
      value: 129.90,
      date: DateTime.now(),
    ),
    Transaction(
      id: "t6",
      title: "Conta Internet",
      value: 129.90,
      date: DateTime.now(),
    ),
    Transaction(
      id: "t7",
      title: "Conta Internet",
      value: 129.90,
      date: DateTime.now(),
    ),
    Transaction(
      id: "t8",
      title: "Conta Internet",
      value: 129.90,
      date: DateTime.now(),
    ),
    Transaction(
      id: "t9",
      title: "Conta Internet",
      value: 129.90,
      date: DateTime.now(),
    ),
    Transaction(
      id: "t10",
      title: "Conta Internet",
      value: 129.90,
      date: DateTime.now(),
    ),
  ];

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
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TransactionForm(_addTransaction),
        TransactionList(_transcations),
      ],
    );
  }
}
