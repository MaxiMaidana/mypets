import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mypets/feature/home/presentation/getx/home_controller.dart';
import 'package:sizer/sizer.dart';

class ButtomNavBarPV extends GetWidget<HomeController> {
  const ButtomNavBarPV({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 1.w,
        right: 1.w,
        bottom: 0.5.h,
      ),
      child: Container(
        width: 98.w,
        height: 10.h,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.25),
              offset: const Offset(0, 4),
              blurRadius: 4,
            )
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Obx(
              () => InkWell(
                onTap: () => controller.paginaActual(0),
                child: SizedBox(
                  height: 40,
                  width: 40,
                  child: controller.index.value == 0
                      ? Icon(
                          Icons.house,
                          size: 35,
                          color: Theme.of(context).colorScheme.primary,
                        )
                      : const Icon(
                          Icons.house_outlined,
                          size: 35,
                        ),
                ),
              ),
            ),
            Obx(
              () => InkWell(
                onTap: () => controller.paginaActual(1),
                child: SizedBox(
                  height: 40,
                  width: 40,
                  child: controller.index.value == 1
                      ? Icon(
                          Icons.book,
                          color: Theme.of(context).colorScheme.primary,
                          size: 35,
                        )
                      : const Icon(
                          Icons.book_outlined,
                          size: 35,
                        ),
                ),
              ),
            ),
            Obx(
              () => InkWell(
                onTap: () => controller.paginaActual(2),
                child: SizedBox(
                  height: 40,
                  width: 40,
                  child: controller.index.value == 2
                      ? Icon(
                          Icons.pest_control_rodent,
                          size: 35,
                          color: Theme.of(context).colorScheme.primary,
                        )
                      : const Icon(
                          Icons.pest_control_rodent_outlined,
                          size: 35,
                        ),
                ),
              ),
            ),
            Obx(
              () => InkWell(
                onTap: () => controller.paginaActual(3),
                child: SizedBox(
                  height: 40,
                  width: 40,
                  child: controller.index.value == 3
                      ? Icon(
                          Icons.person,
                          size: 35,
                          color: Theme.of(context).colorScheme.primary,
                        )
                      : const Icon(
                          Icons.person_outline,
                          size: 35,
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
