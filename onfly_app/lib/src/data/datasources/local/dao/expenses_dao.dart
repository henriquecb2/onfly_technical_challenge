import 'package:floor/floor.dart';

import '../../../../domain/models/expense_model.dart';
import '../../../../utils/constants/strings.dart';

@dao
abstract class ExpensesDao {
  @Query('SELECT * FROM $expensesTableName')
  Future<List<ExpenseModel>> findAllExpenses();

  @Query('SELECT * FROM $expensesTableName WHERE isSynced = false')
  Future<List<ExpenseModel>> getExpensesPendingSync();

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertExpense(ExpenseModel expense);

  @update
  Future<void> updateExpense(ExpenseModel expense);

  @delete
  Future<void> deleteExpense(ExpenseModel expense);
}
