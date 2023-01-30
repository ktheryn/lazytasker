part of 'tasker_bloc.dart';

@immutable
abstract class TaskerEvent extends Equatable {
  const TaskerEvent();

  @override
  List<Object?> get props => [];

}

class LoadTaskEvent extends TaskerEvent{
  @override
  List<Object?> get props => [];
}

class addTaskEvent extends TaskerEvent {
  final Task task;
  const addTaskEvent({required this.task});
  @override
  List<Object?> get props => [task];
}

class removeTaskEvent extends TaskerEvent {
  final Task task;
  const removeTaskEvent({required this.task});

  @override
  List<Object?> get props => [task];
}

class clickCheckBox extends TaskerEvent {
  final Task task;
  const clickCheckBox({required this.task});

  @override
  List<Object?> get props => [task];
}

class saveCheckBox extends TaskerEvent {
  final Task task;
  const saveCheckBox({required this.task});

  @override
  List<Object?> get props => [task];
}




