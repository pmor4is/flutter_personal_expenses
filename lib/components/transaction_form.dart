import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'adaptative_button.dart';
import 'adaptative_text_field.dart';

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
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Padding(
          padding: EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
            bottom: 10 + MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Column(
            //Faz o tamanho mínimo necessário para a coluna, devido ao isScrollControlled. Caso não fosse o mínimo, iria cobrir a tela inteira
            mainAxisSize: MainAxisSize.min,
            children: [
              AdaptativeTextField(
                controller: _titleController,
                label: 'Título',
                onSubmitted: (_) => _submitForm(),
              ),
              AdaptativeTextField(
                keyboardType: TextInputType.numberWithOptions(
                  decimal: true,
                ),
                controller: _valueController,
                label: 'Valor (R\$)',
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
                    TextButton(
                      style: TextButton.styleFrom(
                        primary: Theme.of(context).colorScheme.primary,
                      ),
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
                  AdaptativeButton(
                      label: 'Nova transação', onPressed: _submitForm),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
