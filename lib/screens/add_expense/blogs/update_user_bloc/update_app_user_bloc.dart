import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:expense_repository/expense_repository.dart';


part 'update_app_user_event.dart';
part 'update_app_user_state.dart';

class UpdateAppUserBloc
    extends Bloc<UpdateAppUserEvent, UpdateAppUserState> {
  final ExpenseRepository expenseRepository;

  UpdateAppUserBloc(this.expenseRepository) : super(UpdateAppUserInitial()) {
    on<UpdateAppUser>((event, emit) async {
      emit(UpdateAppUserLoading());

      try {
        await expenseRepository.updateUser(event.uid, event.lastLogin);
        emit(UpdateAppUserSuccess());
      } catch (e) {
        emit(UpdateAppUserFailure());
      }
    });
  }
}