import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../domain/models/expense_model.dart';
import '../cubits/expenses/cubit/expenses_cubit.dart';

class ExpensesFormView extends StatefulWidget {
  ExpenseModel? expense;

  ExpensesFormView({
    super.key,
    this.expense,
  });

  @override
  _ExpensesFormViewState createState() => _ExpensesFormViewState();
}

class _ExpensesFormViewState extends State<ExpensesFormView> {
  final _formKey = GlobalKey<FormState>();
  String _description = '';
  double _amount = 0.0;
  String _category = 'Alimentação';
  DateTime _date = DateTime.now();
  late final ExpensesCubit _cubit;

  @override
  void initState() {
    _cubit = BlocProvider.of<ExpensesCubit>(context);

    if (widget.expense != null) {
      _description = widget.expense!.description;
      _amount = widget.expense!.amount;
      _category = widget.expense!.category;
      _date = widget.expense!.dateTime;
    }

    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    bool _isEditing = widget.expense != null;
    TextEditingController controller = TextEditingController();

    Future<Null> _selectDate(BuildContext context) async {
      final DateTime? picked = await showDatePicker(
          context: context,
          initialDate: _date,
          firstDate: DateTime(2000),
          lastDate: DateTime.now());

      if (picked != null && picked != _date)
        setState(() {
          _date = picked;
          controller.text = '${DateFormat('dd/MM/yyyy').format(_date)}';
        });
    }

    return Scaffold(
      appBar: AppBar(
            title: Text(_isEditing ? 'Editar despesa' : 'Adicionar despesa'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
          )),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              decoration: const InputDecoration(labelText: 'Descrição'),
              initialValue: _description,
              validator: (value) {
                if (value?.isEmpty == true) {
                  return 'Please enter a description';
                }
                return null;
              },
              onSaved: (value) {
                _description = value ?? _description;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Valor'),
              initialValue: _amount.toString(),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value?.isEmpty == true) {
                  return 'Please enter an amount';
                }
                return null;
              },
              onSaved: (value) {
                _amount = value != null ? double.parse(value) : _amount;
              },
            ),
            DropdownButtonFormField<String>(
              value: _category,
              decoration: InputDecoration(labelText: 'Categoria'),
              items: ['Alimentação', 'Hospedagem', 'Transporte', 'Outros']
                  .map((category) => DropdownMenuItem(
                        value: category,
                        child: Text(category),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _category = value ?? _category;
                });
              },
            ),
            Row(
              children: [
                const Text('Data:'),
                TextButton(
                  onPressed: () => _selectDate(context),
                  child: Text(
                    '${DateFormat('dd/MM/yyyy').format(_date)}',
                  ),
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState?.validate() == true) {
                  _formKey.currentState?.save();

                  ExpenseModel expense = ExpenseModel(
                    id: widget.expense?.id ?? null,
                    description: _description,
                    amount: _amount,
                    category: _category,
                    dateTime: _date,
                  );

                  if (_isEditing) {
                    _cubit.updateExpense(expense);
                  } else{
                    _cubit.saveExpense(expense);
                  }

                  Navigator.of(context).pop();
                }
              },
              child: const Text(' Salvar '),
            ),
          ],
        ),
      ),
    );
  }
}
