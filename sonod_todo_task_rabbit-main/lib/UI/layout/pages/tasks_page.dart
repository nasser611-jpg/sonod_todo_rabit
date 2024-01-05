import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:task_rabbit/UI/layout/colors.dart';
import 'package:task_rabbit/UI/layout/widgets/AddSubjectBtn.dart';
import 'package:task_rabbit/UI/layout/widgets/task_Item.dart';
import 'package:task_rabbit/UI/layout/widgets/titel_page.dart';
import 'package:task_rabbit/cubit/task_cubit_cubit.dart';
import 'package:window_manager/window_manager.dart';

class TasksPage extends StatefulWidget {
  const TasksPage({super.key});

  @override
  State<TasksPage> createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage> {
  bool isMaximized = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 40,
                child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 12),
                    child: InkWell(
                      onTap: () {
                        windowManager.minimize();
                      },
                      child: SizedBox(
                        height: 20,
                        width: 24,
                        child: Padding(
                          padding: const EdgeInsets.all(3),
                          child: SvgPicture.asset("images/minimize.svg",
                              width: 18),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    child: InkWell(
                      onTap: () async {
                        if (isMaximized == false) {
                          windowManager.setMinimumSize(const Size(774, 512));
                          windowManager.maximize();
                          isMaximized = true;
                        } else {
                          windowManager.restore();
                          isMaximized = false;
                        }
                      },
                      child: SizedBox(
                        height: 20,
                        width: 24,
                        child: Padding(
                          padding: const EdgeInsets.all(3),
                          child: SvgPicture.asset("images/fullscreen.svg",
                              width: 24),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    child: InkWell(
                      onTap: () {
                        windowManager.close();
                      },
                      child: SizedBox(
                        height: 20,
                        width: 24,
                        child: Padding(
                          padding: const EdgeInsets.all(3),
                          child: SvgPicture.asset(
                            "images/close.svg",
                            width: 24,
                          ),
                        ),
                      ),
                    ),
                  ),
                ]),
              ),
            ),
            const TitelPage(taskcount: 10, text: "Personal Task"),
            const Expanded(
                child: TaskItem(
              subjectId: 9,
            ))
          ],
        ),
        Positioned(
          right: 50,
          bottom: 50,
          child: BlocBuilder<TaskCubitCubit, TaskCubitState>(
            builder: (context, state) {
              return InkWell(
                onTap: () {
                  // TODO :: Add new Task
                  AddSubjectBtn.indexpage = 1;
                  BlocProvider.of<TaskCubitCubit>(context).getdata();
                },
                child: Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF06937),
                    boxShadow: [
                      BoxShadow(
                        color: LayoutColors.shadowColor,
                        blurRadius: 2,
                        offset: const Offset(4, 4),
                        spreadRadius: 0,
                      )
                    ],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Center(
                    child: Text(
                      '+',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        )
      ],
    );
  }
}
