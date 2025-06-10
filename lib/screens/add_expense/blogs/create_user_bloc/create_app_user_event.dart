part of 'create_app_user_bloc.dart';

sealed class CreateAppUserEvent extends Equatable {
  const CreateAppUserEvent();

  @override
  List<Object> get props => [];
}

class CreateAppUser extends CreateAppUserEvent {
  final AppUser appUser;

  const CreateAppUser(this.appUser);

  @override
  List<Object> get props => [appUser];
}
