import 'dart:async';

import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import '../../../domain/models/expense_model.dart';
import 'converters/datetime_type_converter.dart';
import 'dao/expenses_dao.dart';

part 'app_database.g.dart'; // the generated code will be there

@TypeConverters([DateTimeTypeConverter])
@Database(version: 2, entities: [ExpenseModel])
abstract class AppDatabase extends FloorDatabase {
  // Define the data access objects
  ExpensesDao get getExpenseDao;
}