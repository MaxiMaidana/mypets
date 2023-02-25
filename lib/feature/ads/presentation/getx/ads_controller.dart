import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:mypets/feature/ads/domain/model/ad_model.dart';

import '../../../firebase/getx/firebase_controller.dart';

class AdsController extends GetxController with StateMixin {
  final FirebaseController _firebaseController = Get.find();

  late CollectionReference _collectionReference;

  RxList<AdModel> adsList = <AdModel>[
    AdModel(
      title: 'Purina',
      imageUrl:
          'https://www.purina-latam.com/sites/default/files/2022-04/cat-chow-seco-humedo-productos.jpg',
      url:
          'https://www.purina.com.ar/purina?gclid=Cj0KCQiA3eGfBhCeARIsACpJNU9ccxuWAp3nnYrOx2ZDeX8ap1PI7Pv1nejN9Epy735cOid5U5xPiBUaAjdlEALw_wcB',
    ),
    AdModel(
      title: 'Tiernitos',
      imageUrl:
          'https://images.evisos.com.ar/2014/06/18/venta-por-mayor-y-menor-de-alimento-tiernitos_dbbb582c_3.jpg',
      url: 'https://nutribonmascotas.com.ar/',
    ),
    AdModel(
      title: 'Vital can',
      imageUrl:
          'https://www.vitalcan.com/english/wp-content/uploads/2022/07/Banner-web-balanced.jpg',
      url:
          'https://www.vitalcan.com/buscador-de-alimentos/?&utm_campaign=Institucional&utm_source=search&utm_content=textads&utm_medium=cpc&utm_term=vitalcan&gclid=Cj0KCQiA3eGfBhCeARIsACpJNU_a2JeZdRKSwulsAkxZ8PaRQPupMbA3vUoN9Ndph-LG3Cu33uFWdiMaAlWrEALw_wcB',
    ),
  ].obs;

  @override
  void onInit() {
    _collectionReference =
        _firebaseController.connectWithFirebaseCollection('ads');

    super.onInit();
  }
}
