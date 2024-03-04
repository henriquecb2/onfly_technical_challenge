import '../../domain/models/expense_model.dart';
import '../../domain/repositories/expenses_database_repository.dart';
import '../datasources/local/app_database.dart';

class ExpensesDatabaseRepositoryImpl implements ExpensesDatabaseRepository {
  final AppDatabase _database;

  ExpensesDatabaseRepositoryImpl(this._database);

  @override
  Future<void> deleteExpense(ExpenseModel expense) async {
    return _database.getExpenseDao.deleteExpense(expense);
  }

  @override
  Future<void> updateExpense(ExpenseModel expense) async {
    return _database.getExpenseDao.updateExpense(expense);
  }

  @override
  Future<List<ExpenseModel>> getAllExpenses() async {
    return _database.getExpenseDao.findAllExpenses();
  }

  @override
  Future<void> saveExpense(ExpenseModel expense) async {
    return _database.getExpenseDao.insertExpense(expense);
  }
  
  @override
  Future<List<ExpenseModel>> getExpensesPendingSync() {
    return _database.getExpenseDao.getExpensesPendingSync();
  }
}