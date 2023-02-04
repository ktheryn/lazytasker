part of 'tasker_bloc.dart';

@immutable
abstract class TaskerState extends Equatable {
  const TaskerState();

  @override
  List<Object?> get props => [];
}

class TaskerInitial extends TaskerState {
  @override
  List<Object?> get props => [];
}

class TaskerLoaded extends TaskerState {
  final List<Task> tasks;

  const TaskerLoaded({required this.tasks});

  @override
  List<Object?> get props => [tasks];
}

class TaskerError extends TaskerState {
  final String error;

  const TaskerError({required this.error});

  @override
  List<Object?> get props => [error];
}
