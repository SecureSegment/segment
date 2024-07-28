import 'xray_service.dart';

class XrayServiceImpl implements XrayService {
  static Future<void> initializeXray() async {
    throw UnimplementedError(
        'initializeXray() has not been implemented on this platform.');
  }

  static Future<void> stopXray() async {
    throw UnimplementedError(
        'stopXray() has not been implemented on this platform.');
  }

  static Future<bool> isXrayRunning() async {
    throw UnimplementedError(
        'isXrayRunning() has not been implemented on this platform.');
  }
}
