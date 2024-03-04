import '../models/expense_model.dart';

abstract class ExpensesDatabaseRepository {
  Future<List<ExpenseModel>> getAllExpenses();
  Future<List<ExpenseModel>> getExpensesPendingSync();
  Future<void> saveExpense(ExpenseModel expense);
  Future<void> updateExpense(ExpenseModel expense);
  Future<void> deleteExpense(ExpenseModel expense);
}