import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:haajaree/data/models/user_model.dart';
import 'package:haajaree/data/repositories/auth_repository.dart';
import 'package:haajaree/data/repositories/database_repository.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final DatabaseRepository _databaseRepository;
  final AuthRepository _authRepository;
  UserBloc(this._databaseRepository, this._authRepository)
      : super(UserInitial()) {
    on<SetUserModelEvent>(_setUserModelEvent);
    on<GetUserModelEvent>(_getUserModelEvent);
  }
  _setUserModelEvent(SetUserModelEvent event, Emitter<UserState> emit) async {
    emit(UserLoading());
    try {
      await _databaseRepository.setUserData(event.userModel);
      emit(UserSuccess(event.userModel));
    } catch (e) {
      emit(UserFailure(e.toString()));
    }
  }

  _getUserModelEvent(GetUserModelEvent event, Emitter<UserState> emit) async {
    emit(UserLoading());
    try {
      final user = _authRepository.currentUser;
      if (user != null) {
        final userModel = await _databaseRepository.fetchUserData(user.uid);
        if (userModel != null) {
          emit(UserSuccess(userModel));
        } else {
          emit(const UserFailure('Null'));
        }
      }
    } catch (e) {
      emit(UserFailure(e.toString()));
    }
  }
}
