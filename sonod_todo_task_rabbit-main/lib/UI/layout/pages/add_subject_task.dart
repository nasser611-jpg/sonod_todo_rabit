import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:task_rabbit/UI/layout/widgets/titel_page.dart';
import 'package:task_rabbit/bloc/task_bloc.dart';
import 'package:task_rabbit/bloc/task_event.dart';
import 'package:task_rabbit/constants/buttons.dart';
import 'package:window_manager/window_manager.dart';

// ignore: must_be_immutable
class AddSubjectTask extends StatelessWidget {
  bool isMaximized = false;
  static TextEditingController SubjectController = TextEditingController();

  AddSubjectTask({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
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
                      child: SvgPicture.asset("images/minimize.svg", width: 18),
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
                      child:
                          SvgPicture.asset("images/fullscreen.svg", width: 24),
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
        const TitelPage(text: "Add New Task Subject "),
        const SizedBox(
            height: 50,
            child: Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: EdgeInsets.only(right: 50),
                  child: Text(
                    'Content',
                    style: TextStyle(
                      color: Color(0xFF374957),
                      fontSize: 16,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ))),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50),
          child: Theme(
            data: Theme.of(context).copyWith(
              inputDecorationTheme: InputDecorationTheme(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                filled: true,
                fillColor: Colors.grey[200],
              ),
            ),
            child: TextField(
              controller: SubjectController,
              decoration: const InputDecoration(
                hintText: "Write Task Subject",
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 50),
            child: InkWell(
              onTap: () {
                // TODO :: Add New Subject Task
              },
              child: Container(
                width: 148,
                height: 60,
                decoration: ShapeDecoration(
                  color: const Color(0xFFA5236E),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
                child: TextButton(
                  onPressed: () {
                    BlocProvider.of<TaskBloc>(context)
                        .add(CreateTaskEvent(SubjectController.text));
                    constant.showSnackbar(context, 'Added successfully');
                  },
                  child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          '+',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w400,
                            height: 0,
                          ),
                        ),
                        Text(
                          'Add Subject',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w500,
                            height: 0,
                          ),
                        ),
                      ]),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
