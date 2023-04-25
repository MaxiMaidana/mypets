import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/widgets/input_custom.dart';

class RowItemTime extends StatelessWidget {
  final TextEditingController textInit;
  final TextEditingController textFinish;
  final Icon icon;
  final Function() functionInit;
  final Function() functionFinish;
  const RowItemTime({
    super.key,
    required this.textInit,
    required this.textFinish,
    required this.icon,
    required this.functionInit,
    required this.functionFinish,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: functionInit,
          child: Row(
            children: [
              icon,
              SizedBox(width: 10.w),
              SizedBox(
                width: 30.w,
                child: InputCustom.base(
                  controller: textInit,
                  hint: 'Inicio',
                  isEnable: false,
                ),
              ),
            ],
          ),
        ),
        const Spacer(),
        GestureDetector(
          onTap: functionFinish,
          child: SizedBox(
            width: 30.w,
            child: InputCustom.base(
              controller: textFinish,
              hint: 'Fin',
              isEnable: false,
            ),
          ),
        ),
      ],
    );
  }
}
