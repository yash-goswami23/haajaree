part of 'user_bloc.dart';

sealed class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

final class UserInitial extends UserState {}

final class UserLoading extends UserState {}

final class UserSuccess extends UserState {
  final UserModel userModel;
  const UserSuccess(this.userModel);
}

final class UserFailure extends UserState {
  final String error;
  const UserFailure(this.error);
}
