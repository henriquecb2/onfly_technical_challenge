import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';

import '../../utils/constants/strings.dart';

@Entity(tableName: expensesTableName)
class ExpenseModel extends Equatable {
  @PrimaryKey(autoGenerate: true)
  final int? id;

  final String category;
  final DateTime dateTime;
  final String description;
  final double amount;
  final bool isSynced;

  ExpenseModel({
    this.id,
    required this.category,
    required this.dateTime,
    required this.description,
    required this.amount,
    this.isSynced = false,
  });

  factory ExpenseModel.fromMap(Map<String, dynamic> map) {
    return ExpenseModel(
      id: map['id'] != null ? map['id'] as int : null,
      category: map['category'],
      dateTime: DateTime.parse(map['dateTime']),
      description: map['description'],
      amount: map['amount'].toDouble(),
      isSynced: map['isSynced'] as bool,
    );
  }

  ExpenseModel copyWith({
    int? id,
    String? category,
    DateTime? dateTime,
    String? description,
    double? amount,
    bool? isSynced,
  }) {
    return ExpenseModel(
      id: id ?? this.id,
      category: category ?? this.category,
      dateTime: dateTime ?? this.dateTime,
      description: description ?? this.description,
      amount: amount ?? this.amount,
      isSynced: isSynced ?? false,
    );
  }

  @override
  List<Object?> get props => [id, category, dateTime, description, amount, isSynced];
}