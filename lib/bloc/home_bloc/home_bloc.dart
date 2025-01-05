import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:haajaree/data/models/home_model.dart';
import 'package:haajaree/data/repositories/database_repository.dart';
import 'package:intl/intl.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final DatabaseRepository _databaseRepository;
  List<HomeModel>? homeList;
  HomeBloc(
    this._databaseRepository,
  ) : super(HomeInitial()) {
    on<SetAttencesModelEvent>(_setAttencesModelEvent);
    on<GetAttenceModelEvent>(_getAttenceModelEvent);
  }

  _setAttencesModelEvent(
      SetAttencesModelEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoading());
    try {
      final yearPath = DateTime.now().year.toString();
      final monthPath = DateFormat('M').format(DateTime.now()).toString();

      await _databaseRepository.setUserAttendanceData(
          yearPath, monthPath, event.homeModel.date, event.homeModel);
      if (homeList != null) {
        homeList!.clear();
        homeList = await _databaseRepository.fetchUserAttendanceData(
            yearPath, monthPath);
      } else {
        homeList = [event.homeModel];
      }
      emit(DbAttencesSuccess(homeList!));
    } catch (e) {
      emit(HomeFailure(e.toString()));
    }
  }

  _getAttenceModelEvent(
      GetAttenceModelEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoading());
    try {
      final yearPath = DateTime.now().year.toString();
      final monthPath = DateFormat('M').format(DateTime.now()).toString();
      homeList = await _databaseRepository.fetchUserAttendanceData(
          yearPath, monthPath);
      if (homeList != null) {
        if (homeList!.isNotEmpty) {
          emit(DbAttencesSuccess(homeList!));
        }
      } else {
        emit(HomeFirstData());
      }
    } catch (e) {
      emit(HomeFailure(e.toString()));
    }
  }
}
