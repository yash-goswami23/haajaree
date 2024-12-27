part of 'home_bloc.dart';

sealed class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

final class HomeInitial extends HomeState {}

final class DbAttencesSuccess extends HomeState {
  final List<HomeModel> homeModelList;
  const DbAttencesSuccess(this.homeModelList);
}

final class HomeLoading extends HomeState {}

final class HomeFirstData extends HomeState {}

final class HomeFailure extends HomeState {
  final String error;
  const HomeFailure(this.error);
}
