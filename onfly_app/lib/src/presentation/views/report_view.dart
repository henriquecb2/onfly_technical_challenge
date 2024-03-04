// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:pie_chart/pie_chart.dart';

import '../../domain/models/expense_model.dart';
import '../cubits/expenses/cubit/expenses_cubit.dart';

class ReportView extends StatefulWidget {
  ReportView({
    Key? key,
    // required this.expenses,
  }) : super(key: key);

  @override
  State<ReportView> createState() => _ReportViewState();
}

class _ReportViewState extends State<ReportView> {
  // List<ExpenseModel> expenses;
  late final ExpensesCubit _cubit;

  @override
  void initState() {
    _cubit = BlocProvider.of<ExpensesCubit>(context);
    _cubit.getExpenses();

    super.initState();
  }

  Map<String, double> _convertListToMapChart(List<ExpenseModel> expenses) {
    Map<String, double> dataMap = {};

    for (ExpenseModel expense in expenses) {
      if (dataMap.containsKey(expense.category)) {
        dataMap[expense.category] =
            (dataMap[expense.category] ?? 0) + expense.amount;
      } else {
        dataMap[expense.category] = expense.amount;
      }
    }

    return dataMap;
  }

  
  Map<String, List<ExpenseModel>> _convertListToMap(List<ExpenseModel> expenses) {
    Map<String, List<ExpenseModel>> dataMap = {};

    for (ExpenseModel expense in expenses) {
      if (dataMap.containsKey(expense.category)) {
        dataMap[expense.category]?.add(expense);
      } else {
        dataMap[expense.category] = [expense];
      }
    }

    return dataMap;
  }

  Map<String, double> dataMap = {
    "Flutter": 5,
    "React": 3,
    "Xamarin": 2,
    "Ionic": 2,
  };

  final colorList = <Color>[
    Colors.greenAccent,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Relatório de Despesas"),
      ),
      body: BlocBuilder<ExpensesCubit, ExpensesState>(
        builder: (context, state) {
          if(state is ExpensesLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is ExpensesSuccess) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  PieChart(
                  dataMap: _convertListToMapChart(state.expenses),
                  chartType: ChartType.ring,
                  animationDuration: Duration(milliseconds: 800),
                ),
                const SizedBox(height: 16),
                Expanded(child: _buildList(_convertListToMap(state.expenses))),
                //_buildList(_convertListToMap(state.expenses)),
                ],
              ),
            );
          } else {
              return const Center(
                child: Text('Erro, tente novamente mais tarde.'),
              );
          }
        },
      ),
    );
  }



    Widget _buildList(Map<String, List<ExpenseModel>> expensesByCategory) {
      return ListView.builder(
        itemCount: expensesByCategory.keys.length,
        itemBuilder: (context, index) {
          String category = expensesByCategory.keys.elementAt(index);
          List<ExpenseModel> expenses = (expensesByCategory[category] ?? []);

          return Column(
            children: [
              // Category section
              ListTile(
                title: Text(
                  category,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              // Expense list
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: expenses.length,
                itemBuilder: (context, expenseIndex) {
                  ExpenseModel expense = expenses[expenseIndex];
                  return Card(
                    child: ListTile(
                      title: Text(
                        expense.description,
                      ),
                      subtitle: Row(
                        children: [
                          Text(DateFormat('dd/MM/yyyy').format(expense.dateTime)),
                          const Spacer(),
                          Text(expense.amount.toString()),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          );
        },
      );
    }
}
