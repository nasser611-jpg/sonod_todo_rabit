import 'package:flutter/material.dart';

class TitelPage extends StatelessWidget {
  const TitelPage({super.key, this.taskcount = 0, this.text = ""});

  final int taskcount;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 50),
      child: Column(
        children: [
          Row(

            children: [
              Container(
                width: 4,
                height: 30,
                margin: const EdgeInsets.only(left: 8),
                decoration: ShapeDecoration(
                  color: const Color(0xFFF06937),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
              ),
               Align(
                alignment: Alignment.centerRight,
                child: Text(
                 text,
                  style: const TextStyle(
                    color: Color(0xFF374957),
                    fontSize: 24,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w700,
                    height: 0,
                  ),
                ),
              ),
const Spacer(),
                   Align(
                alignment: Alignment.centerLeft,
                child: IconButton(onPressed: (){}, icon: const Icon( Icons.arrow_back_ios_new_sharp) ),
              ),
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            children: [
              taskcount != 0
                  ? Container(
                      width: 7,
                      height: 7,
                      decoration: const ShapeDecoration(
                        color: Color(0xFFF06937),
                        shape: OvalBorder(),
                      ),
                    )
                  : const SizedBox(),
              taskcount != 0
                  ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Text(
                        '$taskcount Tasks',
                        style: const TextStyle(
                          color: Color(0xFFF06937),
                          fontSize: 12,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w400,
                          height: -0.3,
                        ),
                      ),
                    )
                  : const SizedBox(),
              const Expanded(
                child: Divider(
                  height: 1,
                  color: Color(0xFFEFF3F6),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
