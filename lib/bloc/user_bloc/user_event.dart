part of 'user_bloc.dart';

sealed class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class SetUserModelEvent extends UserEvent {
  final UserModel userModel;
  // final String jobTime;
  // final String monthlySalary;
  const SetUserModelEvent(this.userModel);
}

class GetUserModelEvent extends UserEvent {}
