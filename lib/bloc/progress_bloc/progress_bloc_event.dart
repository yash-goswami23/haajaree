part of 'progress_bloc_bloc.dart';

sealed class ProgressBlocEvent extends Equatable {
  const ProgressBlocEvent();

  @override
  List<Object> get props => [];
}

class SetProgressEvent extends ProgressBlocEvent {
  final ProgressModel progressModel;
  const SetProgressEvent(this.progressModel);
}

class GetProgressEvent extends ProgressBlocEvent {}
