import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_rabbit/UI/layout/colors.dart';
import 'package:task_rabbit/cubit/task_cubit_cubit.dart';

class AddSubjectBtn extends StatefulWidget {
  static int indexpage = 0;
  const AddSubjectBtn({super.key});

  @override
  State<AddSubjectBtn> createState() => _AddSubjectBtnState();
}

class _AddSubjectBtnState extends State<AddSubjectBtn> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskCubitCubit, TaskCubitState>(
      bloc: TaskCubitCubit(),
      builder: (context, state) {
        return TextButton(
          onPressed: () {
            AddSubjectBtn.indexpage = 2;

            BlocProvider.of<TaskCubitCubit>(context).getdata();
          },
          child: MouseRegion(
            cursor: SystemMouseCursors.click,
            child: Container(
              width: 270,
              height: 60,
              decoration: ShapeDecoration(
                gradient: const LinearGradient(
                  begin: Alignment(-1.00, -0.00),
                  end: Alignment(1, 0),
                  colors: [
                    Color.fromARGB(22, 55, 73, 87),
                    Color(0x00374957),
                    Color.fromARGB(22, 55, 73, 87)
                  ],
                ),
                shape: RoundedRectangleBorder(
                  side: const BorderSide(width: 1, color: Color(0x3F374957)),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Row(
                children: [
                  Container(
                    margin: const EdgeInsets.all(6),
                    width: 45,
                    height: 45,
                    decoration: BoxDecoration(
                        color: LayoutColors.primaryColor,
                        borderRadius: BorderRadius.circular(4)),
                    child: const Center(
                      child: Text(
                        '+',
                        style: TextStyle(
                          color: Color(0xFFDDE2E6),
                          fontSize: 20,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w400,
                          height: -0.3,
                        ),
                      ),
                    ),
                  ),
                  const Expanded(
                      child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'Add Subject',
                      style: TextStyle(
                        color: Color(0xFF374957),
                        fontSize: 16,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ))
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
