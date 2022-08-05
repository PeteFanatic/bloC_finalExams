import 'package:bloc_finals_exam/bloc/blocExports.dart';
import 'package:bloc_finals_exam/models/task.dart';
import 'package:equatable/equatable.dart';

import 'taskEvent.dart';
import 'taskState.dart';

class TasksBloc extends HydratedBloc<TasksEvent, TasksState> {
  TasksBloc() : super(const TasksState()) {
    on<AddTask>(_onAddTask);
    on<UpdateTask>(_onUpdateTask);
    on<DeleteTask>(_onDeleteTask);
    on<RemoveTask>(_onRemoveTask);
  }

  void _onAddTask(AddTask event, Emitter<TasksState> emit) {
    final state = this.state;
    emit(TasksState(
      pendingTasks: List.from(state.pendingTasks)..add(event.task),
      completedTasks: state.completedTasks,
      favoriteTasks: state.favoriteTasks,
      removedTasks: state.removedTasks,
    ));
  }
}

void _onUpdateTask(UpdateTask event, Emitter<TasksState> emit) {
  final state = this.state;
  final task = event.task;

  List<Task> pendingTasks = state.pendingTasks;
  List<Task> completedTasks = state.completedTasks;
  List<Task> favoriteTasks = state.favoriteTasks;
  if (task.isDone == false) {
    if (task.isFavorite == false) {
      pendingTasks = List.from(pendingTasks)..remove(task);
      completedTasks.insert(0, task.copyWith(isDone: true));
    } else {
      var taskIndex = favoriteTasks.indexOf(task);
      pendingTasks = List.from(pendingTasks)..remove(task);
      completedTasks.insert(0, task.copyWith(isDone: true));
      favoriteTasks = List.from(favoriteTasks)
        ..remove(task)
        ..insert(taskIndex, task.copyWith(isDone: true));
    }
  } else {
    if (task.isFavorite == false) {
      completedTasks = List.from(completedTasks)..remove(task);
      pendingTasks = List.from(pendingTasks)
        ..insert(0, task.copyWith(isDone: false));
    } else {
      var taskIndex = favoriteTasks.indexOf(task);
      completedTasks = List.from(completedTasks)..remove(task);
      pendingTasks = List.from(pendingTasks)
        ..insert(0, task.copyWith(isDone: false));
      favoriteTasks = List.from(favoriteTasks)
        ..remove(task)
        ..insert(taskIndex, task.copyWith(isDone: false));
    }
  }
  emit(TasksState(
    pendingTasks: pendingTasks,
    completedTasks: completedTasks,
    favoriteTasks: state.favoriteTasks,
    removedTasks: state.removedTasks,
  ));
}

void _onDeleteTask(DeleteTask event, Emitter<TasksState> emit) {
  final state = this.state;
  emit(TasksState(
    pendingTasks: state.pendingTasks,
    completedTasks: state.completedTasks,
    favoriteTasks: state.favoriteTasks,
    removedTasks: List.from(state.removedTasks)..remove(event.task),
  ));
}

void _onRemoveTask(RemoveTask event, Emitter<TasksState> emit) {
  final state = this.state;
  emit(TasksState(
    pendingTasks: List.from(state.pendingTasks)..remove(event.task),
    completedTasks: List.from(state.completedTasks)..remove(event.task),
    favoriteTasks: List.from(state.favoriteTasks)..remove(event.task),
    removedTasks: List.from(state.removedTasks)
      ..add(event.task.copyWith(isDeleted: true)),
  ));
}
