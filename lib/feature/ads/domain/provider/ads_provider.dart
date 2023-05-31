import 'package:mypets/data/datasource/firebase_datasource.dart';
import 'package:mypets/feature/ads/domain/model/ad_model.dart';

import '../../../../data/models/response_model.dart';

class AdsProvider {
  Future<List<AdModel>> getAllAds() async {
    try {
      List<AdModel> lsRes = [];
      ResponseModel responseModel =
          await FirebaseDatasource(collection: 'ads').getAllData();
      if (responseModel.data != null) {
        List res = responseModel.data as List;
        for (var item in res) {
          lsRes.add(AdModel.fromJson(item));
        }
      }
      return lsRes;
    } catch (e) {
      rethrow;
    }
  }
}
