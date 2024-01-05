import '../model/task_model.dart';

abstract class TaskEvent {}

class FetchTasksEvent extends TaskEvent {}

class CreateTaskEvent extends TaskEvent {
  final String task;

  CreateTaskEvent(this.task);
}

class FetchSubtasksEvent extends TaskEvent {
  final int taskId;

  FetchSubtasksEvent(this.taskId);
}

class CreateSubtaskEvent extends TaskEvent {
  final bool isChecked;
  final String taskContent;
  final int subjectId;

  CreateSubtaskEvent(this.isChecked, this.taskContent, this.subjectId);

  List<Object?> get props => [isChecked, taskContent, subjectId];
}

class UpdateSubtaskEvent extends TaskEvent {
  final SubTask subtask;

  UpdateSubtaskEvent(this.subtask);
}

class DeleteSubtaskEvent extends TaskEvent {
  final int subtaskId;

  DeleteSubtaskEvent(this.subtaskId);
}
