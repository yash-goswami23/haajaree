import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:haajaree/data/models/user_model.dart';
import 'package:haajaree/data/repositories/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;
  AuthBloc(this._authRepository) : super(AuthInitial()) {
    on<SignUpEvent>(_signUpEvent);
    on<LoginEvent>(_loginEvent);
    on<SiginWithGoogle>(_siginWithGoogle);
    on<SignOutEvent>(_signOutEvent);
  }
  _signUpEvent(SignUpEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final user = await _authRepository.signup(
          event.fullName, event.email, event.password);
      if (user != null) {
        final userModel = UserModel(
            email: user.email,
            fullName: event.fullName,
            password: event.password,
            uID: user.uid);
        emit(AuthSuccess(userModel));
      }
    } catch (e) {
      emit(AuthFailure(_authRepository.getErrorMessage(e.toString())));
    }
  }

  _loginEvent(LoginEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final user = await _authRepository.login(event.email, event.password);
      if (user != null) {
        final userModel =
            UserModel(email: event.email, password: event.password);
        emit(AuthSuccess(userModel));
      }
    } catch (e) {
      emit(AuthFailure(_authRepository.getErrorMessage(e.toString())));
    }
  }

  _siginWithGoogle(SiginWithGoogle event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final user = await _authRepository.signInWithGoogle();
      if (user != null && user.user != null) {
        // final userModel = UserModel(
        //   email: user.user!.email,
        //   fullName: user.user!.displayName,
        //   password: user.credential!.token.toString(),
        //   uID: user.user!.uid,
        // );
        emit(AuthGoogleSuccess(user));
      }
    } catch (e) {
      emit(AuthFailure(_authRepository.getErrorMessage(e.toString())));
    }
  }

  _signOutEvent(SignOutEvent event, Emitter<AuthState> emit) {
    emit(AuthLoading());
    try {
      _authRepository.signout();
      emit(AuthInitial());
    } catch (e) {
      emit(AuthFailure(_authRepository.getErrorMessage(e.toString())));
    }
  }
}
