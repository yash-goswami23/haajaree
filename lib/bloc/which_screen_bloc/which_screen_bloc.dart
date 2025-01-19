import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:haajaree/data/repositories/auth_repository.dart';
import 'package:haajaree/data/repositories/database_repository.dart';

part 'which_screen_event.dart';
part 'which_screen_state.dart';

class WhichScreenBloc extends Bloc<WhichScreenEvent, WhichScreenState> {
  final AuthRepository authRepo;
  final DatabaseRepository dbRepo;
  WhichScreenBloc(this.authRepo, this.dbRepo) : super(WhichScreenInitial()) {
    on<CheckWhichScreenEvent>((event, emit) async {
      final currentUser = authRepo.currentUser;
      if (currentUser != null) {
        final userData = await dbRepo.fetchUserData(currentUser.uid);
        if (userData == null) {
          // mainscreen
          currentUser.delete();
          emit(InWelcomeScreen());
        } else {
          emit(InMainScreen());
        }
      } else {
        emit(InWelcomeScreen());
      }
    });
  }
}
