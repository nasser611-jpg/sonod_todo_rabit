import 'package:bloc/bloc.dart';
import 'package:task_rabbit/bloc/task_event.dart';
import 'package:task_rabbit/curd/add_subject.dart';
import 'package:task_rabbit/curd/delete_content.dart';
import 'package:task_rabbit/data/services/services_content.dart';
import 'package:task_rabbit/data/services/services_subject.dart';
import 'package:task_rabbit/model/sub_task_model.dart';

import '../model/task_model.dart';

part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  TaskBloc() : super(InitialTaskState()) {
    on<CreateTaskEvent>(_onCreateTaskEvent);
    on<FetchSubtasksEvent>(_onFetchSubtasksEvent);
    on<CreateSubtaskEvent>(_onCreateSubtaskEvent);
    on<DeleteSubtaskEvent>(_onDeleteSubTaskEvent);

    // Add this line
  }
  int SubjectId = 1;
  void _onFetchSubtasksEvent(
      FetchSubtasksEvent event, Emitter<TaskState> emit) async {
    try {
      final List<SubTask> subtasks =
          await SubTaskApiService.fetchSubtasks(event.taskId);
      emit(LoadedSubtasksState(subtasks));
    } catch (e) {
      emit(ErrorSubtasksState("Failed to fetch subtasks: $e"));
    }
  }

  void _onCreateTaskEvent(
      CreateTaskEvent event, Emitter<TaskState> emit) async {
    print('Creating task: ${event.task}');
    try {
      await AddTaskRequest.addTask(event.task);
      final List<Task> tasks = await TaskApiService.fetchTasks();
      emit(LoadedTasksState(tasks));
    } catch (e) {
      emit(ErrorTaskState("Failed to create task: $e"));
    }
  }

  void _onCreateSubtaskEvent(
      CreateSubtaskEvent event, Emitter<TaskState> emit) async {
    try {
      print('the evene is is ${event.subjectId}');
      await SubTaskApiService.addSubtask(AddSubtaskRequest.fromJson({
        "taskContent": event.taskContent,
        "isCheched": event.isChecked,
        "subject": event.subjectId
      }));
      final int taskId = event.subjectId;
      final List<SubTask> subtasks =
          await SubTaskApiService.fetchSubtasks(taskId);

      // Optionally, filter subtasks based on taskId if needed
      // final List<SubTask> filteredSubtasks =
      //     subtasks.where((subtask) => subtask.id == taskId).toList();

      emit(LoadedSubtasksState(subtasks));
    } catch (e) {
      emit(ErrorSubtasksState("Failed to create subtask: $e"));
    }
  }

  void _onDeleteSubTaskEvent(
      DeleteSubtaskEvent event, Emitter<TaskState> emit) async {
    try {
      SubTaskApiService.deleteSubtask(event.subtaskId);
    } catch (e) {
      print('Erorr in Deletion $e');
    }
  }

  Stream<TaskState> _mapAddTaskToState(String taskName) async* {
    yield LoadingTaskState();
    // Dispatch the CreateTaskEvent
    add(CreateTaskEvent(taskName));
  }

  Stream<TaskState> mapEventToState(TaskEvent event) async* {
    if (event is FetchTasksEvent) {
      yield* _mapFetchTasksToState();
    } else if (event is CreateTaskEvent) {
      yield* _mapAddTaskToState(event.task);
    } else if (event is FetchSubtasksEvent) {
      yield* _mapFetchSubtasksToState(event.taskId);
    } else if (event is CreateSubtaskEvent) {
      yield* _mapCreateSubtaskToState(SubTask(
          id: event.subjectId,
          taskContent: event.taskContent,
          isCheched: event.isChecked,
          subject: event.subjectId));
    } else if (event is UpdateSubtaskEvent) {
      yield* _mapUpdateSubtaskToState(event.subtask);
    } else if (event is DeleteSubtaskEvent) {
      yield* _mapDeleteSubtaskToState(event.subtaskId);
    }
  }

  Stream<TaskState> _mapFetchTasksToState() async* {
    yield LoadingTaskState();
    try {
      final List<Task> tasks = await TaskApiService.fetchTasks();
      yield LoadedTasksState(tasks);
    } catch (e) {
      yield ErrorTaskState("Failed to fetch tasks: $e");
    }
  }

  Stream<TaskState> _mapFetchSubtasksToState(int taskId) async* {
    yield LoadingTaskState();
    try {
      final List<SubTask> subtasks =
          await SubTaskApiService.fetchSubtasks(taskId);

      final List<SubTask> filteredSubtasks =
          subtasks.where((subtask) => subtask.id == taskId).toList();

      yield LoadedSubtasksState(filteredSubtasks);
    } catch (e) {
      yield ErrorSubtasksState("Failed to fetch subtasks: $e");
    }
  }

  Stream<TaskState> _mapCreateSubtaskToState(SubTask subtask) async* {
    final int taskId = subtask.id;
    yield* _mapFetchSubtasksToState(taskId);
  }

  Stream<TaskState> _mapUpdateSubtaskToState(SubTask subtask) async* {
    final int taskId = subtask.id;
    yield* _mapFetchSubtasksToState(taskId);
  }

  Stream<TaskState> _mapDeleteSubtaskToState(int subtaskId) async* {
    final dynamic taskId = SubtaskApiDeletion.deleteSubtask(subtaskId);
    yield* _mapFetchSubtasksToState(taskId);
  }
}
