import '../../../../data/datasource/firebase_datasource.dart';
import '../../../../data/models/pet/specie_model.dart';
import '../../../../data/models/response_model.dart';

class PetInfoSupportProvider {
  Future<List<SpecieModel>> callAlBreeds() async {
    try {
      List<SpecieModel> lsRes = [];
      ResponseModel responseModel =
          await FirebaseDatasource('breed').getAllData();
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
}
