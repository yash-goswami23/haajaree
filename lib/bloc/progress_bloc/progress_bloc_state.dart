part of 'progress_bloc_bloc.dart';

sealed class ProgressBlocState extends Equatable {
  const ProgressBlocState();

  @override
  List<Object> get props => [];
}

final class ProgressBlocInitial extends ProgressBlocState {}

final class ProgressBlocLoading extends ProgressBlocState {}

final class ProgressBlocSuccess extends ProgressBlocState {
  final ProgressModel progressModel;
  const ProgressBlocSuccess(this.progressModel);
}

final class ProgressBlocFailure extends ProgressBlocState {
  final String error;
  const ProgressBlocFailure(this.error);
}
