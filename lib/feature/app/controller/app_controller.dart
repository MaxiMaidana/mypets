import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AppController extends GetxController {
  late PackageInfo packageInfo;
  @override
  void onInit() async {
    packageInfo = await PackageInfo.fromPlatform();
    super.onInit();
  }
}
