part of 'create_expense_bloc.dart';

sealed class CreateExpenseEvent extends Equatable {
  const CreateExpenseEvent();

  @override
  List<Object> get props => [];
}

class CreareExpense extends CreateExpenseEvent {
  final Expense expense;

  const CreareExpense(this.expense);

  @override
  List<Object> get props => [expense];

}
