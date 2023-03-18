import 'package:get/get.dart';

import '../../../../data/models/pet/fur_model.dart';
import '../../../../data/models/pet/size_model.dart';
import '../../../../data/models/pet/specie_model.dart';
import '../../domain/provider/pet_info_support_provider.dart';

class PetInfoSupportController extends GetxController {
  final _petInfoSupportProvider = PetInfoSupportProvider();
  List<SpecieModel> lsSpecies = [];
  List<FurModel> lsFurs = [];
  List<SizeModel> lsSizes = [];

  Future<void> initData() async {
    try {
      await Future.wait([
        callBreeds(),
        callFurs(),
        callSizes(),
      ]);
    } catch (e) {
      return;
    }
  }

  Future<void> callBreeds() async {
    try {
      lsSpecies.addAll(await _petInfoSupportProvider.callBreeds());
    } catch (e) {
      rethrow;
    }
  }

  Future<void> callFurs() async {
    try {
      lsFurs.addAll(await _petInfoSupportProvider.callFurs());
    } catch (e) {
      rethrow;
    }
  }

  Future<void> callSizes() async {
    try {
      lsSizes.addAll(await _petInfoSupportProvider.callSizes());
    } catch (e) {
      rethrow;
    }
  }

  @override
  void onInit() {
    initData();
    super.onInit();
  }
}
