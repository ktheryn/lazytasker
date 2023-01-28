import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:lazytasker/tasker_notification.dart';
import 'package:lazytasker/tasker_repository.dart';
import 'package:meta/meta.dart';
import 'model.dart';
part 'tasker_event.dart';
part 'tasker_state.dart';

class TaskerBloc extends Bloc<TaskerEvent, TaskerState> {
  final TaskerRepository _taskerRepository;
  TaskerBloc(this._taskerRepository) : super(TaskerInitial()) {

    on<LoadTaskEvent>((event, emit) async  {
      emit(TaskerInitial());
      try {
        final tasks = await _taskerRepository.retrieveTask();
        emit(TaskerLoaded(tasks: tasks));
      } catch (e) {
        emit(TaskerError(error: e.toString()));
      }
    });

    on<addTaskEvent>((event, emit) {
      if (state is TaskerLoaded) {
        final state = this.state as TaskerLoaded;
        List<Task> tasker = [];
        tasker.add(event.task);
        _taskerRepository.insertTask(tasker);
        NotifyHelper().showNotification(state.tasks.length, event.task.taskName, event.task.date);
        emit(TaskerLoaded(tasks: List.from(state.tasks)..add(event.task)));
      }
    });

    on<removeTaskEvent>((event, emit) {
      if (state is TaskerLoaded) {
        final state = this.state as TaskerLoaded;
        List<Task> tasker = [];
        tasker.add(event.task);
        final int index = state.tasks.indexOf(event.task);
        _taskerRepository.deleteTask(tasker[index].id);
        emit(TaskerLoaded(tasks: List.from(state.tasks)..remove(event.task)));
      }
    });

    on<clickCheckBox>((event, emit) {
      if (state is TaskerLoaded) {
        final state = this.state as TaskerLoaded;
        final task = event.task;
        final int index = state.tasks.indexOf(task);

        List<Task> allTasks = List.from(state.tasks)..remove(task);
        task.isCheck == 'false' ? allTasks.insert(index, task.copyWith(isCheck: 'true')) :
        allTasks.insert(index, task.copyWith(isCheck: 'false'));
        emit(TaskerLoaded(tasks: allTasks));
      }
    });







  }

}
