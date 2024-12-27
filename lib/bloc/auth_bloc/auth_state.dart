part of 'auth_bloc.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}

final class AuthFailure extends AuthState {
  final String error;
  const AuthFailure(this.error);
}

final class AuthSuccess extends AuthState {
  final UserModel userModel;
  const AuthSuccess(this.userModel);
}

final class AuthGoogleSuccess extends AuthState {
  final UserCredential userCredential;
  const AuthGoogleSuccess(this.userCredential);
}
