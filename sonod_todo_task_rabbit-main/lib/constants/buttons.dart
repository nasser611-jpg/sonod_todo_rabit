import 'package:flutter/material.dart';
import 'package:task_rabbit/UI/layout/pages/add_subject_task.dart';
import 'package:task_rabbit/UI/layout/pages/tasks_form.dart';
import 'package:task_rabbit/UI/layout/pages/tasks_page.dart';

class constant {
  static int indexPage = 0;
  static TextEditingController titleController = TextEditingController();
  static TextEditingController descriptionController = TextEditingController();
  constant();

  static Widget btn(String text, Function() ontap) {
    return TextButton(onPressed: ontap, child: Text(text));
  }

  static void showSnackbar(BuildContext context, String msg) {
    final snackBar = SnackBar(
      content: Text(
        msg,
        textAlign: TextAlign.center,
      ),
      duration: const Duration(seconds: 3),
      backgroundColor: Colors.green,
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static List<Widget> pages = [const TasksPage(), TaskForm(), AddSubjectTask()];

  static int indexpage = 0;
}
