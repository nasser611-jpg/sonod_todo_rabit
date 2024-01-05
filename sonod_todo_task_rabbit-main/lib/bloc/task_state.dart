part of 'task_bloc.dart';

abstract class TaskState {}

class InitialTaskState extends TaskState {}

class LoadingTaskState extends TaskState {}

class LoadedTasksState extends TaskState {
  final List<Task> tasks;

  LoadedTasksState(this.tasks);
}

class ErrorTaskState extends TaskState {
  final String error;

  ErrorTaskState(this.error);
}

class LoadedSubtasksState extends TaskState {
  final List<SubTask> subtasks;

  LoadedSubtasksState(this.subtasks);
}

class ErrorSubtasksState extends TaskState {
  final String error;

  ErrorSubtasksState(this.error);
}
