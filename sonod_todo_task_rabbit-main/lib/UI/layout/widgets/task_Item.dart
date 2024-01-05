import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:task_rabbit/UI/layout/colors.dart';
import 'package:task_rabbit/bloc/task_bloc.dart';
import 'package:task_rabbit/bloc/task_event.dart';
import 'package:task_rabbit/curd/update_content.dart';
import 'package:task_rabbit/model/task_model.dart';

class TaskItem extends StatefulWidget {
  final int subjectId;

  const TaskItem({Key? key, required this.subjectId}) : super(key: key);

  @override
  State<TaskItem> createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  List<bool> checkboxValues = []; // List to store checkbox values

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 50),
        height: 60,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(9),
          boxShadow: [
            BoxShadow(
              color: LayoutColors.shadowColor,
              blurRadius: 4,
              offset: const Offset(0, 0),
              spreadRadius: 0,
            )
          ],
        ),
        child: BlocBuilder<TaskBloc, TaskState>(
          builder: (context, state) {
            if (state is LoadedSubtasksState) {
              return ListView.builder(
                itemCount: state.subtasks.length,
                itemBuilder: (context, index) {
                  final SubTask subtask = state.subtasks[index];

                  return Row(
                    children: [
                      SizedBox(
                        height: 60,
                        width: 60,
                        child: Checkbox(
                          value: checkboxValues.length > index
                              ? checkboxValues[index]
                              : false,
                          activeColor: LayoutColors.taskColor.elementAt(0),
                          onChanged: (value) {
                            setState(() {
                              if (checkboxValues.length <= index) {
                                checkboxValues.add(value!);
                              } else {
                                checkboxValues[index] = value!;
                              }
                            });
                          },
                        ),
                      ),
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            subtask.taskContent,
                            style: const TextStyle(
                              color: Color(0xFF374957),
                              fontSize: 16,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w500,
                              height: 0,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 100,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            BlocBuilder<TaskBloc, TaskState>(
                              builder: (context, state) {
                                return InkWell(
                                  onTap: () {
                                    UpdateContent(subtask: subtask)
                                        .showUpdateContentDialog(
                                            subtask.subject,
                                            context,
                                            subtask.id,
                                            subtask.taskContent);
                                  },
                                  child: SvgPicture.asset(
                                    "images/pencil.svg",
                                    width: 20,
                                    height: 20,
                                  ),
                                );
                              },
                            ),
                            InkWell(
                              onTap: () {
                                BlocProvider.of<TaskBloc>(context)
                                    .add(DeleteSubtaskEvent(subtask.id));
                              },
                              child: SvgPicture.asset(
                                "images/trash.svg",
                                width: 20,
                                height: 20,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              );
            } else {
              return const CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}
