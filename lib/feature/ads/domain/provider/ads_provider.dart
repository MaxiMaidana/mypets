import 'dart:developer';

import 'package:mypets/data/datasource/firebase_datasource.dart';
import 'package:mypets/feature/ads/domain/model/ad_model.dart';

import '../../../../data/models/response_model.dart';

class AdsProvider {
  Future<List<AdModel>> getAllAds() async {
    try {
      List<AdModel> lsRes = [];
      log('get all ads');
      ResponseModel responseModel =
          await FirebaseDatasource('ads').getAllData();
      if (responseModel.data != null) {
        List res = responseModel.data as List;
        for (var item in res) {
          lsRes.add(AdModel.fromJson(item));
        }
      }
      // if (res.data != null) {
      //   for (var item in res.data as List) {
      //     Map<String, dynamic> itemMap = item.data() as Map<String, dynamic>;
      //     lsRes.add(AdModel.fromJson(itemMap));
      //   }
      // }
      return lsRes;
    } catch (e) {
      rethrow;
    }
  }
}
