part of 'task_cubit_cubit.dart';

abstract class TaskCubitState {}

final class TaskCubitInitial extends TaskCubitState {}
class LoadingDataState extends TaskCubitState{}
class SucessDataState extends TaskCubitState{}
class failuarDataState extends TaskCubitState{}
