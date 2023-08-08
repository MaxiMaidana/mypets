import 'dart:async';

import 'package:get/get.dart';
import 'package:mypets/main.dart';

import 'check_internet_connection.dart';

class ConnectionStatusController extends GetxController {
  late StreamSubscription<ConnectionStatus> _connectionStatusSubscription;

  final status = Rx<ConnectionStatus>(ConnectionStatus.init);

  ConnectionStatusController() {
    _connectionStatusSubscription = internetChecker
        .internetStatus()
        .listen((event) => status.value = event);
  }

  @override
  void dispose() {
    _connectionStatusSubscription.cancel();
    super.dispose();
  }
}
