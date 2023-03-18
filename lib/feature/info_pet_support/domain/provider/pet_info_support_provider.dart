import '../../../../data/datasource/firebase_datasource.dart';
import '../../../../data/models/pet/fur_model.dart';
import '../../../../data/models/pet/size_model.dart';
import '../../../../data/models/pet/specie_model.dart';
import '../../../../data/models/response_model.dart';

class PetInfoSupportProvider {
  Future<List<SpecieModel>> callBreeds() async {
    try {
      List<SpecieModel> lsRes = [];
      ResponseModel responseModel =
          await FirebaseDatasource(collection: 'breed').getAllData();
      if (responseModel.data != null) {
        List res = responseModel.data as List;
        for (var item in res) {
          lsRes.add(SpecieModel.fromJson(item));
        }
      }
      return lsRes;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<FurModel>> callFurs() async {
    try {
      List<FurModel> lsRes = [];
      ResponseModel responseModel =
          await FirebaseDatasource(collection: 'furs').getAllData();
      if (responseModel.data != null) {
        List res = responseModel.data as List;
        for (var item in res) {
          lsRes.add(FurModel.fromJson(item));
        }
      }
      return lsRes;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<SizeModel>> callSizes() async {
    try {
      List<SizeModel> lsRes = [];
      ResponseModel responseModel =
          await FirebaseDatasource(collection: 'sizes').getAllData();
      if (responseModel.data != null) {
        List res = responseModel.data as List;
        for (var item in res) {
          lsRes.add(SizeModel.fromJson(item));
        }
      }
      return lsRes;
    } catch (e) {
      rethrow;
    }
  }
}
