import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/widgets/input_custom.dart';

class RowItemDate extends StatelessWidget {
  final Icon icon;
  final String hint;
  final Function() function;
  final TextEditingController textController;
  const RowItemDate({
    super.key,
    required this.icon,
    required this.hint,
    required this.function,
    required this.textController,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function,
      child: Row(
        children: [
          icon,
          const Spacer(),
          SizedBox(
            width: 70.w,
            child: InputCustom.base(
              controller: textController,
              hint: hint,
              isEnable: false,
            ),
          )
        ],
      ),
    );
  }
}
