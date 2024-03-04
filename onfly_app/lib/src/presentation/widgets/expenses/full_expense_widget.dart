import 'package:flutter/material.dart';

import '../../../domain/models/expense_model.dart';

class CardWidget extends StatelessWidget {
  final ExpenseModel expense;

  const CardWidget({super.key, required this.expense});

  @override
  Widget build(BuildContext context) {
    return Card (
      child: ExpansionTile(
        title: ListTile(
          title: Text(expense.description),
          subtitle: Text("R\$: ${expense.amount}"),
          //leading: Icon(Icons.train),
        ),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {},
                child: const Text('Editar'),
              ),
              ElevatedButton(
                onPressed: () {},
                child: const Text('Excluir'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
