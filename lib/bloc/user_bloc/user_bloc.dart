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
      : super(DbInitial()) {
    on<SetUserModelEvent>(_setUserModelEvent);
    on<GetUserModelEvent>(_getUserModelEvent);
  }
  _setUserModelEvent(SetUserModelEvent event, Emitter<UserState> emit) async {
    emit(DbLoading());
    try {
      await _databaseRepository.setUserData(event.userModel);

      emit(DbUserModelSuccess(event.userModel));
    } catch (e) {
      emit(DbFailure(e.toString()));
    }
  }

  _getUserModelEvent(GetUserModelEvent event, Emitter<UserState> emit) async {
    emit(DbLoading());
    try {
      final user = _authRepository.currentUser;
      if (user != null) {
        final userModel = await _databaseRepository.fetchUserData(user.uid);
        if (userModel != null) {
          emit(DbUserModelSuccess(userModel));
        }
      }
    } catch (e) {
      emit(DbFailure(e.toString()));
    }
  }
}
