import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class PageWithWitgetAtEnd extends StatelessWidget {
  final Widget widgetEnd;
  final Widget textWidget;
  const PageWithWitgetAtEnd({
    super.key,
    required this.widgetEnd,
    required this.textWidget,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.only(left: 5.w, right: 5.w),
          child: Column(
            children: [
              SizedBox(height: 15.h),
              Icon(
                Icons.graphic_eq_outlined,
                size: 30.h,
              ),
              SizedBox(height: 3.h),
              textWidget,
              const Spacer(),
              widgetEnd,
              SizedBox(height: 2.h),
            ],
          ),
        ),
      ),
    );
  }
}
