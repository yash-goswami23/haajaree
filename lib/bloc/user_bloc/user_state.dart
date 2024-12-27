part of 'user_bloc.dart';

sealed class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

final class DbInitial extends UserState {}

final class DbLoading extends UserState {}

final class DbUserModelSuccess extends UserState {
  final UserModel userModel;
  const DbUserModelSuccess(this.userModel);
}

final class DbFailure extends UserState {
  final String error;
  const DbFailure(this.error);
}
