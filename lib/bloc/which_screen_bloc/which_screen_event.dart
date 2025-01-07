part of 'which_screen_bloc.dart';

sealed class WhichScreenEvent extends Equatable {
  const WhichScreenEvent();

  @override
  List<Object> get props => [];
}

class CheckWhichScreenEvent extends WhichScreenEvent {}
