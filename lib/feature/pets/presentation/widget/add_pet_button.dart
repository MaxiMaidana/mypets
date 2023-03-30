import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:mypets/core/widgets/dialog_custom.dart';
import 'package:mypets/feature/pets/presentation/getx/pets_controller.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/routes/routes.dart';

class AddPetButton extends GetWidget<PetsController> {
  const AddPetButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (controller.petInfoSupportController.lsSpecies.isNotEmpty &&
            controller.petInfoSupportController.lsFurs.isNotEmpty) {
          context.push(Routes.newPet);
        } else {
          DialogCustom.infoDialog(context,
              title: 'Upps :/',
              message:
                  'En estos momentos no podemos agregar mascota, intente de nuevo mas tarde.');
        }
      },
      child: Container(
        height: 100,
        width: 100.w,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary.withOpacity(0.7),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 4),
              blurRadius: 4,
              color: Colors.black.withOpacity(0.3),
            )
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Agregar mascota',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const Icon(
              Icons.add,
              size: 40,
            ),
          ],
        ),
      ),
    );
  }
}
