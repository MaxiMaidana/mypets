import 'package:get/get.dart';
import 'package:mypets/feature/ads/domain/model/ad_model.dart';
import 'package:mypets/feature/ads/domain/provider/ads_provider.dart';

class AdsController extends GetxController with StateMixin {
  final AdsProvider adsProvider = AdsProvider();

  RxList<AdModel> adsList = <AdModel>[].obs;

  Future<void> getAds() async {
    try {
      adsList.addAll(await adsProvider.getAllAds());
    } catch (e) {
      rethrow;
    }
  }

  @override
  void onInit() {
    getAds();
    super.onInit();
  }
}
