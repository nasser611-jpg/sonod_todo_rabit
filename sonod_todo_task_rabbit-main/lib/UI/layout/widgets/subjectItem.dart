import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:task_rabbit/UI/layout/colors.dart';
import 'package:task_rabbit/UI/layout/widgets/AddSubjectBtn.dart';
import 'package:task_rabbit/bloc/task_bloc.dart';
import 'package:task_rabbit/bloc/task_event.dart';
import 'package:task_rabbit/cubit/task_cubit_cubit.dart';
import 'package:task_rabbit/model/task_model.dart';

class SubjectItem extends StatelessWidget {
  const SubjectItem(
      {super.key,
      required this.colors,
      required this.taskSubject,
      this.isActive = false,
      this.onTap});
  final Color colors;
  final Task taskSubject;
  final bool isActive;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: () {},
          child: Container(
            margin: const EdgeInsets.all(5),
            height: 60,
            width: 270,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(9),
                border: isActive ? Border.all(color: colors, width: 1) : null,
                boxShadow: [
                  BoxShadow(
                    color: LayoutColors.shadowColor,
                    blurRadius: 2,
                    offset: const Offset(0, 0),
                    spreadRadius: 0,
                  )
                ]),
            child: Row(
              children: [
                Container(
                  width: 8,
                  height: 60,
                  decoration: ShapeDecoration(
                    color: colors,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(8),
                        bottomRight: Radius.circular(8),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: SvgPicture.asset(
                    "images/calander.svg",
                    color: colors,
                    width: 24,
                    height: 24,
                  ),
                ),
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    BlocBuilder<TaskCubitCubit, TaskCubitState>(
                      builder: (context, state) {
                        return TextButton(
                          onPressed: () {
                            BlocProvider.of<TaskBloc>(context)
                                .add(FetchSubtasksEvent(taskSubject.id));
                            AddSubjectBtn.indexpage = 0;
                            BlocProvider.of<TaskBloc>(context).SubjectId =
                                taskSubject.id;
                            BlocProvider.of<TaskCubitCubit>(context).getdata();
                          },
                          child: Text(
                            taskSubject.name,
                            style: const TextStyle(
                              color: Color(0xFF374957),
                              fontSize: 18,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w500,
                              height: 1.3,
                            ),
                          ),
                        );
                      },
                    ),
                    Text(
                      '${taskSubject.id} Tasks',
                      style: const TextStyle(
                        color: Color(0xFF697781),
                        fontSize: 12,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                        height: 1.3,
                      ),
                    ),
                  ],
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
