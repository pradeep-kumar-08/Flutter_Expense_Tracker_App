part of 'update_app_user_bloc.dart';

sealed class UpdateAppUserEvent extends Equatable {
  const UpdateAppUserEvent();

  @override
  List<Object> get props => [];
}

class UpdateAppUser extends UpdateAppUserEvent {
  final String uid;
  final DateTime lastLogin;

  const UpdateAppUser(this.uid, this.lastLogin);

  @override
  List<Object> get props => [uid, lastLogin];
}
