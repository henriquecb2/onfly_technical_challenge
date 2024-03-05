import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:onfly_app/src/data/datasources/local/app_database.dart';
import 'package:onfly_app/src/data/datasources/local/dao/expenses_dao.dart';
import 'package:onfly_app/src/data/repositories/expenses_database_repository.dart';
import 'package:onfly_app/src/domain/models/expense_model.dart';

class MockAppDatabase extends Mock implements AppDatabase {}

class MockDao extends Mock implements ExpensesDao {}

void main() {
  group('ExpensesDatabaseRepository', () {
    late ExpensesDatabaseRepositoryImpl repository;
    late MockAppDatabase mockDatabase;
    late MockDao mockDao;

    setUp(() {
      mockDatabase = MockAppDatabase();
      repository = ExpensesDatabaseRepositoryImpl(mockDatabase);
      mockDao = MockDao();

      when(() => mockDatabase.getExpenseDao).thenReturn(mockDao);
    });

    test(
        'GIVEN a ExpensesDatabaseRepository '
        'WHEN call deleteExpenses '
        'THEN call deleteExpense method in AppDatabase', () async {
      final expense = ExpenseModel(
          amount: 25.0,
          dateTime: DateTime.now(),
          description: 'Test',
          category: 'Test');

      when(() => mockDao.deleteExpense(expense)).thenAnswer((_) async => 1);

      await repository.deleteExpense(expense);

      verify(() => mockDatabase.getExpenseDao.deleteExpense(expense)).called(1);
    });

    test(
        'GIVEN a ExpensesDatabaseRepository '
        'WHEN call updateExpense '
        'THEN call updateExpense method in AppDatabase', () async {
      final expense = ExpenseModel(
          amount: 25.0,
          dateTime: DateTime.now(),
          description: 'Test',
          category: 'Test');

      when(() => mockDao.updateExpense(expense)).thenAnswer((_) async => 1);

      await repository.updateExpense(expense);

      verify(() => mockDatabase.getExpenseDao.updateExpense(expense)).called(1);
    });

    test(
        'GIVEN a ExpensesDatabaseRepository '
        'WHEN call getAllExpenses '
        'THEN call findAllExpenses method in AppDatabase', () async {
      when(() => mockDao.findAllExpenses()).thenAnswer((_) async => []);

      await repository.getAllExpenses();

      verify(() => mockDatabase.getExpenseDao.findAllExpenses()).called(1);
    });

    test(
        'GIVEN a ExpensesDatabaseRepository '
        'WHEN call saveExpense '
        'THEN call insertExpense method in AppDatabase', () async {
      final expense = ExpenseModel(
          amount: 25.0,
          dateTime: DateTime.now(),
          description: 'Test',
          category: 'Test');

      when(() => mockDao.insertExpense(expense)).thenAnswer((_) async => 1);

      await repository.saveExpense(expense);

      verify(() => mockDatabase.getExpenseDao.insertExpense(expense)).called(1);
    });

    test(
        'GIVEN a ExpensesDatabaseRepository '
        'WHEN call getExpensesPendingSync '
        'THEN call getExpensesPendingSync method in AppDatabase', () async {
      when(() => mockDao.getExpensesPendingSync()).thenAnswer((_) async => []);

      await repository.getExpensesPendingSync();

      verify(() => mockDatabase.getExpenseDao.getExpensesPendingSync())
          .called(1);
    });
  });
}
