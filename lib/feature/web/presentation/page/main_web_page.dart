import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mypets/core/routes/routes.dart';
import 'package:sizer/sizer.dart';

class WebMainPage extends StatelessWidget {
  const WebMainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.red,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    child: SizedBox(
                      height: 5.h,
                      width: 7.w,
                      child: const Center(
                        child: Text('Soy Veterinaria',
                            textAlign: TextAlign.center),
                      ),
                    ),
                  ),
                  SizedBox(width: 1.w),
                  ElevatedButton(
                    onPressed: () => context.go(Routes.auth),
                    child: SizedBox(
                      height: 5.h,
                      width: 7.w,
                      child: const Center(
                        child: Text('Ir a mi libreta'),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
