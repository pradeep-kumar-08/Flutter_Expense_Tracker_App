import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:expense_repository/expense_repository.dart';


part 'create_app_user_event.dart';
part 'create_app_user_state.dart';

class CreateAppUserBloc
    extends Bloc<CreateAppUserEvent, CreateAppUserState> {
  final ExpenseRepository expenseRepository;

  CreateAppUserBloc(this.expenseRepository) : super(CreateAppUserInitial()) {
    on<CreateAppUser>((event, emit) async {
      emit(CreateAppUserLoading());

      try {
        await expenseRepository.createUser(event.appUser);
        emit(CreateAppUserSuccess());
      } catch (e) {
        emit(CreateAppUserFailure());
      }
    });
  }
}