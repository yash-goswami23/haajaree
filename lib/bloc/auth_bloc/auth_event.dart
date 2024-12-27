part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class SignUpEvent extends AuthEvent {
  final String fullName;
  final String email;
  final String password;

  const SignUpEvent(
      {required this.fullName, required this.email, required this.password});
}

class LoginEvent extends AuthEvent {
  final String email;
  final String password;
  const LoginEvent({required this.email, required this.password});
}

class SignOutEvent extends AuthEvent {}

class SiginWithGoogle extends AuthEvent {}
