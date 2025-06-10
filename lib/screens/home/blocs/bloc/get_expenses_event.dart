part of 'get_expenses_bloc.dart';

sealed class GetExpensesEvent extends Equatable {
  const GetExpensesEvent();

  @override
  List<Object> get props => [];
}
class GetExpenses extends GetExpensesEvent{
  final String uid;

  const GetExpenses(this.uid);

  @override
  List<Object> get props => [uid];
}
