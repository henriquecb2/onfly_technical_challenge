// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  ExpensesDao? _getExpenseDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 2,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `expenses_table` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `category` TEXT NOT NULL, `dateTime` TEXT NOT NULL, `description` TEXT NOT NULL, `amount` REAL NOT NULL, `isSynced` INTEGER NOT NULL)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  ExpensesDao get getExpenseDao {
    return _getExpenseDaoInstance ??= _$ExpensesDao(database, changeListener);
  }
}

class _$ExpensesDao extends ExpensesDao {
  _$ExpensesDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _expenseModelInsertionAdapter = InsertionAdapter(
            database,
            'expenses_table',
            (ExpenseModel item) => <String, Object?>{
                  'id': item.id,
                  'category': item.category,
                  'dateTime': _dateTimeTypeConverter.encode(item.dateTime),
                  'description': item.description,
                  'amount': item.amount,
                  'isSynced': item.isSynced ? 1 : 0
                }),
        _expenseModelUpdateAdapter = UpdateAdapter(
            database,
            'expenses_table',
            ['id'],
            (ExpenseModel item) => <String, Object?>{
                  'id': item.id,
                  'category': item.category,
                  'dateTime': _dateTimeTypeConverter.encode(item.dateTime),
                  'description': item.description,
                  'amount': item.amount,
                  'isSynced': item.isSynced ? 1 : 0
                }),
        _expenseModelDeletionAdapter = DeletionAdapter(
            database,
            'expenses_table',
            ['id'],
            (ExpenseModel item) => <String, Object?>{
                  'id': item.id,
                  'category': item.category,
                  'dateTime': _dateTimeTypeConverter.encode(item.dateTime),
                  'description': item.description,
                  'amount': item.amount,
                  'isSynced': item.isSynced ? 1 : 0
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<ExpenseModel> _expenseModelInsertionAdapter;

  final UpdateAdapter<ExpenseModel> _expenseModelUpdateAdapter;

  final DeletionAdapter<ExpenseModel> _expenseModelDeletionAdapter;

  @override
  Future<List<ExpenseModel>> findAllExpenses() async {
    return _queryAdapter.queryList('SELECT * FROM expenses_table',
        mapper: (Map<String, Object?> row) => ExpenseModel(
            id: row['id'] as int?,
            category: row['category'] as String,
            dateTime: _dateTimeTypeConverter.decode(row['dateTime'] as String),
            description: row['description'] as String,
            amount: row['amount'] as double,
            isSynced: (row['isSynced'] as int) != 0));
  }

  @override
  Future<List<ExpenseModel>> getExpensesPendingSync() async {
    return _queryAdapter.queryList(
        'SELECT * FROM expenses_table WHERE isSynced = false',
        mapper: (Map<String, Object?> row) => ExpenseModel(
            id: row['id'] as int?,
            category: row['category'] as String,
            dateTime: _dateTimeTypeConverter.decode(row['dateTime'] as String),
            description: row['description'] as String,
            amount: row['amount'] as double,
            isSynced: (row['isSynced'] as int) != 0));
  }

  @override
  Future<void> insertExpense(ExpenseModel expense) async {
    await _expenseModelInsertionAdapter.insert(
        expense, OnConflictStrategy.replace);
  }

  @override
  Future<void> updateExpense(ExpenseModel expense) async {
    await _expenseModelUpdateAdapter.update(expense, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteExpense(ExpenseModel expense) async {
    await _expenseModelDeletionAdapter.delete(expense);
  }
}

// ignore_for_file: unused_element
final _dateTimeTypeConverter = DateTimeTypeConverter();
