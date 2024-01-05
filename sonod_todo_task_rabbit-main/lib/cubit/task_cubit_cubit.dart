import 'package:bloc/bloc.dart';
import 'package:task_rabbit/UI/layout/widgets/AddSubjectBtn.dart';


part 'task_cubit_state.dart';

class TaskCubitCubit extends Cubit<TaskCubitState> {
  TaskCubitCubit() : super(TaskCubitInitial());
  int indexPage=AddSubjectBtn.indexpage;
  void getdata() async{
    indexPage= AddSubjectBtn.indexpage;
    emit(LoadingDataState());
  
  }
}
