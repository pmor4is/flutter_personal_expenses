import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionForm extends StatefulWidget {
  final void Function(String, double, DateTime)? onSubmit;

  TransactionForm(this.onSubmit);

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final _titleController = TextEditingController();
  final _valueController = TextEditingController();
  DateTime? _selectedDate = DateTime.now();

  _submitForm() {
    final title = _titleController.text;
    final value = double.tryParse(_valueController.text) ?? 0.0;

    if (title.isEmpty || value <= 0 || _selectedDate == null) {
      return;
    }

    widget.onSubmit!(title, value, _selectedDate!);
  }

  _showDatePicker() {
    //ShowDatePicker é uma função assíncrona
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }

      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: 'Título',
              ),
              onSubmitted: (_) => _submitForm(),
            ),
            TextField(
              keyboardType: TextInputType.numberWithOptions(
                decimal: true,
              ),
              controller: _valueController,
              decoration: InputDecoration(
                labelText: 'Valor (R\$)',
              ),
              onSubmitted: (_) => _submitForm(),
            ),
            Container(
              height: 70,
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      _selectedDate == null
                          ? 'Nenhuma data selecionada'
                          : 'Data selecionada: ${DateFormat('d/M/y').format(_selectedDate!)}',
                    ),
                  ),
                  FlatButton(
                    textColor: Theme.of(context).colorScheme.primary,
                    child: Text(
                      'Selecionar data',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: _showDatePicker,
                  )
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  child: Text('Nova transação'),
                  style: ElevatedButton.styleFrom(
                    primary: Theme.of(context).colorScheme.primary,
                  ),
                  onPressed: _submitForm,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
