import 'package:get/instance_manager.dart';
import 'package:mypets/core/utils/connection/connection_status_service.dart';
import '../utils/connection/check_internet_connection.dart';

class RequestManger {
  final _connectionStatusController = Get.find<ConnectionStatusController>();

  Future<T?> request<T>(
      {required Future<T> Function() functionOnline,
      Future<T> Function()? functionOffline}) async {
    if (_connectionStatusController.status.value == ConnectionStatus.online) {
      T res = await functionOnline.call();
      return res;
    } else {
      if (functionOffline == null) return null;
      T res = await functionOffline.call();
      return res;
    }
  }
}
