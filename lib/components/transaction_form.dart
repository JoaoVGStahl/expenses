import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';

class TransactionForm extends StatefulWidget {
  final void Function(String, double) onSubmit;

  TransactionForm(this.onSubmit);

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final tittleController = TextEditingController();

  final valueController = TextEditingController();

  _submitForm() {
    final title = tittleController.text;
    final value = double.tryParse(valueController.text) ?? 0.0;

    if (title.isEmpty || value <= 0) {
      return;
    }

    widget.onSubmit(title, value);
  }

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
              onSubmitted: (_) => _submitForm(),
              decoration: InputDecoration(
                labelText: "Título",
              ),
            ),
            TextField(
              controller: valueController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              onSubmitted: (_) => _submitForm(),
              decoration: InputDecoration(
                labelText: "Valor (R\$)",
              ),
            ),
            Container(
              height: 70,
              child: Row(
                children: [
                  Text("Nenhuma data selecionada!"),
                  FlatButton(
                    textColor: Theme.of(context).colorScheme.primary,
                    onPressed: () {},
                    child: Text("Selecionar Data", style: TextStyle(fontWeight: FontWeight.bold),),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                RaisedButton(
                  onPressed: _submitForm,
                  color: Theme.of(context).colorScheme.primary,
                  textColor: Theme.of(context).textTheme.button?.color,
                  child: Text("Nova Transação"),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
