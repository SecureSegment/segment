import 'dart:async';
import 'package:flutter/services.dart';
import 'xray_service.dart';

class XrayServiceImpl implements XrayService {
  static const platform = MethodChannel('com.example.segment/xray');
  static bool _isRunning = false;
  static Timer? _statusCheckTimer;

  static Future<void> initializeXray() async {
    try {
      final result = await platform.invokeMethod('startVpn');
      print("Start VPN result: $result");

      bool isRunning = await _waitForVpnToRun();
      if (!isRunning) {
        throw Exception(
            "VPN service started but is not running after 10 seconds");
      }

      _isRunning = true;
      print("Xray VPN started and running: $_isRunning");
    } on PlatformException catch (e) {
      print("PlatformException when starting Xray VPN: '${e.message}'.");
      throw Exception("Failed to start VPN: ${e.message}");
    } catch (e) {
      print("Unexpected error when starting Xray VPN: $e");
      throw Exception("Unexpected error when starting VPN: $e");
    }
  }

  static Future<bool> _waitForVpnToRun() async {
    for (int i = 0; i < 30; i++) {
      await Future.delayed(Duration(seconds: 1));
      bool running = await isXrayRunning();
      print("VPN running check $i: $running");
      if (running) return true;
    }
    return false;
  }

  static Future<void> stopXray() async {
    try {
      final result = await platform.invokeMethod('stopVpn');
      print("Stop VPN result: $result");
      _isRunning = false;
      _statusCheckTimer?.cancel();
      print("Xray VPN stopped: ${!_isRunning}");
    } on PlatformException catch (e) {
      print("PlatformException when stopping Xray VPN: '${e.message}'.");
      throw Exception("Failed to stop VPN: ${e.message}");
    } catch (e) {
      print("Unexpected error when stopping Xray VPN: $e");
      throw Exception("Unexpected error when stopping VPN: $e");
    }
  }

  static Future<bool> isXrayRunning() async {
    try {
      final result = await platform.invokeMethod('isVpnRunning');
      print("Is VPN running result: $result");
      return result ?? false;
    } on PlatformException catch (e) {
      print("PlatformException when checking Xray VPN status: '${e.message}'.");
      return false;
    } catch (e) {
      print("Unexpected error when checking Xray VPN status: $e");
      return false;
    }
  }

  static void startStatusCheck() {
    _statusCheckTimer = Timer.periodic(Duration(seconds: 5), (timer) async {
      bool running = await isXrayRunning();
      print("Periodic VPN status check: $running");
      if (running != _isRunning) {
        _isRunning = running;
      }
    });
  }
}
