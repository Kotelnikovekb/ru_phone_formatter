import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

import '../constants/colors.dart';

class AppButton extends StatelessWidget {
  final VoidCallback onTap;
  final String title;
  const AppButton({Key? key, required this.onTap, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      splashColor: Colors.transparent,
      child: DottedBorder(
        color: AppColors.graySecond,
        strokeWidth: 1,
        dashPattern: const [5, 5],
        borderType: BorderType.RRect,
        radius: Radius.circular(10),
        child: Container(
          height: 50,
          width: 1,
          decoration: BoxDecoration(
              color: AppColors.white, borderRadius: BorderRadius.circular(10)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
              )
            ],
          ),
        ),
      ),
    );
  }
}
