part of 'update_app_user_bloc.dart';

sealed class UpdateAppUserState extends Equatable {
  const UpdateAppUserState();

  @override
  List<Object> get props => [];
}

final class UpdateAppUserInitial extends UpdateAppUserState {}
final class UpdateAppUserFailure extends UpdateAppUserState {}
final class UpdateAppUserLoading extends UpdateAppUserState {}
final class UpdateAppUserSuccess extends UpdateAppUserState {}
