import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../domain/models/expense_model.dart';
import '../cubits/expenses/cubit/expenses_cubit.dart';
import 'expenses_form.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class ExpensesView extends StatefulWidget {
  @override
  State<ExpensesView> createState() => _ExpensesViewState();
}

class _ExpensesViewState extends State<ExpensesView> {
  late final ExpensesCubit _cubit;

  ConnectivityResult connectivityResult = ConnectivityResult.none;
  Connectivity connectivity = Connectivity();

  @override
  void initState() {
    _cubit = BlocProvider.of<ExpensesCubit>(context);
    _cubit.getExpenses();

    connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
      if (result == ConnectivityResult.wifi) {
        _cubit.syncExpenses();
        _cubit.getExpenses();
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Minhas Despesas'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ExpensesFormView()),
            ).then((value) {
              setState(() {
                _cubit.getExpenses();
              });
            }),
          ),
        ],
      ),
      body: BlocProvider.value(
        value: _cubit,
        child: BlocBuilder<ExpensesCubit, ExpensesState>(
          builder: (context, state) {
            if (state is ExpensesLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is ExpensesSuccess) {
              return Column(
                children: [
                  if (state.expenses.where((e) => !e.isSynced).isNotEmpty)
                  ListTile(
                    title: const Text('Pendende Sincronização'),
                    subtitle: Text(
                        'Total: ${state.expenses.where((e) => !e.isSynced).length}'),
                  ),
                  const SizedBox(height: 16),
                  const Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    child: Align (
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Despesas',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: _buildList(state.expenses),
                  ),
                ],
              );
            } else if (state is ExpensesError) {
              return Center(
                child: Text('Error: ${state.error}'),
              );
            } else {
              return const Center(
                child: Text('Unknown state'),
              );
            }
          },
        ),
      ),
    );
  }

  Widget _buildList(List<ExpenseModel> expenses) {
    return ListView.builder(
      itemCount: expenses
          .length, // Replace with the actual number of items in your list
      itemBuilder: (BuildContext context, int index) {
        return _buildExpenseCard(
          expenses[index],
        );
      },
    );
  }

  Widget _buildExpenseCard(ExpenseModel expense) {
    return Card(
      child: ExpansionTile(
        expandedCrossAxisAlignment: CrossAxisAlignment.start,
        title: ListTile(
          title: Text(expense.description),
          subtitle: Text("R\$: ${expense.amount}"),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
            child: Row(
              children: [
                const Text('Categoria: ', style: const TextStyle(fontWeight: FontWeight.bold)),
                Text('${expense.category}'),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
            child: Row(
              children: [
                const Text('Data: ', style: const TextStyle(fontWeight: FontWeight.bold)),
                Text('${DateFormat('dd/MM/yyyy').format(expense.dateTime)}'),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ExpensesFormView(
                            expense: expense,
                          )),
                ).then((value) {
                  setState(() {
                    _cubit.getExpenses();
                  });
                }),
                child: const Text('Editar'),
              ),
              ElevatedButton(
                onPressed: () {
                  _cubit.deleteExpense(expense);
                },
                child: const Text('Excluir'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
