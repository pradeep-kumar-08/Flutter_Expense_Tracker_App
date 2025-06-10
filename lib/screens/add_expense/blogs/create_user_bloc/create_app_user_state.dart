part of 'create_app_user_bloc.dart';

sealed class CreateAppUserState extends Equatable {
  const CreateAppUserState();

  @override
  List<Object> get props => [];
}

final class CreateAppUserInitial extends CreateAppUserState {}
final class CreateAppUserFailure extends CreateAppUserState {}
final class CreateAppUserLoading extends CreateAppUserState {}
final class CreateAppUserSuccess extends CreateAppUserState {}
