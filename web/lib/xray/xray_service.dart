export 'xray_service_stub.dart'
    if (dart.library.io) 'xray_android.dart'
    if (dart.library.io) 'xray_windows.dart';

import 'dart:async';

abstract class XrayService {
  static Future<void> initializeXray() async {
    throw UnimplementedError('initializeXray() has not been implemented.');
  }

  static Future<void> stopXray() async {
    throw UnimplementedError('stopXray() has not been implemented.');
  }

  static Future<bool> isXrayRunning() async {
    throw UnimplementedError('isXrayRunning() has not been implemented.');
  }
}

class XrayServiceImpl implements XrayService {
  static Future<void> initializeXray() async {}

  static Future<void> stopXray() async {}

  static Future<bool> isXrayRunning() async {
    return false;
  }
}
