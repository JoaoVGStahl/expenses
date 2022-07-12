import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';

class TransactionForm extends StatelessWidget {
  
  final tittleController = TextEditingController();
  final valueController = TextEditingController();

  @override
  Widget build(BuildContext context) {
   return Card(
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    TextField(
                      controller: tittleController,
                      decoration: InputDecoration(
                        labelText: "Título",
                      ),
                    ),
                    TextField(
                      controller: valueController,
                      decoration: InputDecoration(
                        labelText: "Valor (R\$)",
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        FlatButton(
                          onPressed: () {
                            print(tittleController.text);
                            print(valueController.text);
                          },
                          child: Text("Nova Transação"),
                          textColor: Colors.blue,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ); 
  }
}