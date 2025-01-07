import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:haajaree/data/models/progress_model.dart';
import 'package:haajaree/data/repositories/auth_repository.dart';
import 'package:haajaree/data/repositories/database_repository.dart';
import 'package:intl/intl.dart';

part 'progress_bloc_event.dart';
part 'progress_bloc_state.dart';

class ProgressBloc extends Bloc<ProgressBlocEvent, ProgressBlocState> {
  final AuthRepository authRepo;
  final DatabaseRepository dbRepo;
  ProgressBloc(this.authRepo, this.dbRepo) : super(ProgressBlocInitial()) {
    on<SetProgressEvent>(_setProgresseEvent);
    on<GetProgressEvent>(_getProgressEvent);
  }
  _setProgresseEvent(
      SetProgressEvent event, Emitter<ProgressBlocState> emit) async {
    emit(ProgressBlocLoading());
    try {
      final yearPath = DateTime.now().year.toString();
      final monthPath = DateFormat('MMM').format(DateTime.now()).toString();
      await dbRepo.setTotalProgressData(
          yearPath, monthPath, event.progressModel);
      emit(ProgressBlocSuccess(event.progressModel));
    } catch (e) {
      emit(ProgressBlocFailure(e.toString()));
    }
  }

  _getProgressEvent(
      GetProgressEvent event, Emitter<ProgressBlocState> emit) async {
    emit(ProgressBlocLoading());
    try {
      final user = authRepo.currentUser;
      if (user != null) {
        final yearPath = DateTime.now().year.toString();
        final monthPath = DateFormat('MMM').format(DateTime.now()).toString();
        final progressModel =
            await dbRepo.fetchTotalProgressData(yearPath, monthPath);
        if (progressModel != null) {
          emit(ProgressBlocSuccess(progressModel));
        } else {
          emit(const ProgressBlocFailure('Null'));
        }
      }
    } catch (e) {
      emit(ProgressBlocFailure(e.toString()));
    }
  }
}
