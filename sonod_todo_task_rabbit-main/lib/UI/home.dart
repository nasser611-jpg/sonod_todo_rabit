import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:task_rabbit/UI/layout/colors.dart';
import 'package:task_rabbit/constants/buttons.dart';
import 'package:task_rabbit/cubit/task_cubit_cubit.dart';
import 'package:window_manager/window_manager.dart';

import '../data/services/services_subject.dart';
import '../model/task_model.dart';
import 'layout/widgets/AddSubjectBtn.dart';
import 'layout/widgets/subjectItem.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late constant co;

  late Future<List<Task>> tasksFuture;

  @override
  void initState() {
    super.initState();
    tasksFuture = fetchData();
  }

  Future<List<Task>> fetchData() async {
    try {
      final fetchedTasks = await TaskApiService.fetchTasks();
      return fetchedTasks;
    } catch (error) {
      print('Error fetching tasks: $error');
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocBuilder<TaskCubitCubit, TaskCubitState>(
        builder: (context, state) {
          return Row(
            children: [
              GestureDetector(
                onPanStart: (details) => windowManager.startDragging(),
                child: Container(
                  width: 337,
                  color: const Color(0xffEFF3F6),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(80.0),
                        child: SvgPicture.asset(
                          "images/logo.svg",
                          width: 121,
                          height: 73,
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: FutureBuilder<List<Task>>(
                          future: tasksFuture,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const CircularProgressIndicator();
                            } else if (snapshot.hasError) {
                              return const Text('Error fetching tasks');
                            } else {
                              final tasks = snapshot.data ?? [];
                              return ListView.builder(
                                itemCount: tasks.length,
                                itemBuilder: (context, index) {
                                  // Use modulo to wrap around the index
                                  final colorIndex =
                                      index % LayoutColors.taskColor.length;

                                  return TextButton(
                                    onPressed: () {
                                      print('pressed');
                                    },
                                    child: SubjectItem(
                                      isActive: (index == 0) ? true : false,
                                      colors:
                                          LayoutColors.taskColor[colorIndex],
                                      taskSubject: tasks[index],
                                    ),
                                  );
                                },
                              );
                            }
                          },
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Align(child: AddSubjectBtn()),
                      )
                    ],
                  ),
                ),
              ),

              // This Well Navigation Page

              Expanded(
                child: constant.pages.elementAt(
                    BlocProvider.of<TaskCubitCubit>(context).indexPage),
              ),
            ],
          );
        },
      ),
    );
  }
}
