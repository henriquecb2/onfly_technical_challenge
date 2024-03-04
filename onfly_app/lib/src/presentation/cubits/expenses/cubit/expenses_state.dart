part of 'expenses_cubit.dart';

sealed class ExpensesState extends Equatable {
  const ExpensesState();

  @override
  List<Object> get props => [];
}

class ExpensesLoading extends ExpensesState {
  const ExpensesLoading();
}

class ExpensesSuccess extends ExpensesState {
  final List<ExpenseModel> expenses;
  const ExpensesSuccess({required this.expenses});
}

class ExpensesError extends ExpensesState {
  final DioError? error;
  const ExpensesError({this.error});
}
