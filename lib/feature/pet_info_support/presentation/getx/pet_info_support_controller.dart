import 'dart:developer';

import 'package:get/get.dart';

import '../../../../data/models/pet/specie_model.dart';
import '../../domain/provider/pet_info_support_provider.dart';

class PetInfoSupportController extends GetxController {
  final _petInfoSupportProvider = PetInfoSupportProvider();
  List<SpecieModel> lsSpecies = [];

  Future<void> initData() async {
    try {
      lsSpecies.addAll(await _petInfoSupportProvider.callAlBreeds());
      log('vinieron todas las especies ${lsSpecies.length}');
    } catch (e) {
      return;
    }
  }

  @override
  void onInit() {
    initData();
    super.onInit();
  }
}
