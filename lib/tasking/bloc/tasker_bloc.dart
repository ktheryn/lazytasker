import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:lazytasker/tasking/services/tasker_notification.dart';
import 'package:lazytasker/tasking/services/tasker_repository.dart';
import 'package:meta/meta.dart';
import '../model/model.dart';
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

    on<addTaskEvent>((event, emit) async {
      if (state is TaskerLoaded) {
        final state = this.state as TaskerLoaded;
        List<Task> tasker = [];
        tasker.add(event.task);
        NotifyHelper().showNotification(state.tasks.length, event.task.taskName, event.task.taskDate);
        await _taskerRepository.insertTask(tasker);
        emit(TaskerLoaded(tasks: List.from(state.tasks)..add(event.task)));
      }
    });

    on<removeTaskEvent>((event, emit) async {
      if (state is TaskerLoaded) {
        final state = this.state as TaskerLoaded;
       //final int index = state.tasks.indexOf(event.task);
        await _taskerRepository.deleteTask(event.task.id);
        emit(TaskerLoaded(tasks: List.from(state.tasks)..remove(event.task)));
      }
    });

    on<clickCheckBox>((event, emit) {
      if (state is TaskerLoaded) {
        final state = this.state as TaskerLoaded;
        final task = event.task;
        final int index = state.tasks.indexOf(task);

        List<Task> allTasks = List.from(state.tasks)..remove(task);
        task.isMarkCompleted == 'false' ? allTasks.insert(index, task.copyWith(isCheck: 'true')) :
        allTasks.insert(index, task.copyWith(isCheck: 'false'));
        emit(TaskerLoaded(tasks: allTasks));
      }
    });

    on<saveCheckBox>((event, emit) async {
      if (state is TaskerLoaded) {
        final state = this.state as TaskerLoaded;
        final task = event.task;
        await _taskerRepository.updateTask(state.tasks, task.id);
      }
    });
  }

}
