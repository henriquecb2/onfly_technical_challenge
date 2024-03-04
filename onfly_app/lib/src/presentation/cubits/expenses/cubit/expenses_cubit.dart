import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

import '../../../../domain/models/expense_model.dart';
import '../../../../domain/repositories/expenses_database_repository.dart';
import '../../base/base_cubit.dart';

part 'expenses_state.dart';

class ExpensesCubit extends BaseCubit<ExpensesState> {
  final ExpensesDatabaseRepository _repository;

  ExpensesCubit(this._repository) : super(const ExpensesLoading());

  Future<void> getExpenses() async {
    emit(const ExpensesLoading());
    final expenses = await _repository.getAllExpenses();
    emit(ExpensesSuccess(expenses: expenses));
  }

  Future<void> saveExpense(ExpenseModel expense) async {
    await _repository.saveExpense(expense);
  }

  Future<void> deleteExpense(ExpenseModel expense) async {
    await _repository.deleteExpense(expense);
    getExpenses();
  }

  Future<void> updateExpense(ExpenseModel expense) async {
    await _repository.updateExpense(expense);
  }

  Future<void> syncExpenses() async {
    if(isBusy) return;

    await run(() async {
      final expenses = await _repository.getExpensesPendingSync();
      for (final expense in expenses) {
        try {
          //await Dio().post('http://localhost:3000/expenses', data: expense.toJson());
          var updatedExpense = expense.copyWith(isSynced: true);
          await _repository.updateExpense(updatedExpense);
        } catch (e) {
          var updatedExpense = expense.copyWith(isSynced: false);
          await _repository.updateExpense(updatedExpense);
        }
      }
      getExpenses();
    });

  }
}
