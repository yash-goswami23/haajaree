part of 'which_screen_bloc.dart';

sealed class WhichScreenState extends Equatable {
  const WhichScreenState();

  @override
  List<Object> get props => [];
}

final class WhichScreenInitial extends WhichScreenState {}

final class InMainScreen extends WhichScreenState {}

final class InWelcomeScreen extends WhichScreenState {}
