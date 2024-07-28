import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'xray_service.dart';

class XrayServiceImpl implements XrayService {
  static Process? _xrayProcess;

  static Future<void> initializeXray() async {
    try {
      final Directory appDocDir = await getApplicationDocumentsDirectory();
      final String appDocPath = appDocDir.path;
      final File xrayFile = File('$appDocPath/xray.exe');
      final File configFile = File('$appDocPath/config.json');

      await _copyXrayExecutable(xrayFile);
      await _copyConfigFile(configFile);
      await _runXray(xrayFile, configFile);

      if (await isXrayRunning() == false) {
        throw Exception("Xray process started but is not running");
      }
    } catch (e) {
      print("Error initializing Xray: $e");
      throw Exception("Failed to initialize Xray: $e");
    }
  }

  static Future<void> _copyXrayExecutable(File xrayFile) async {
    if (!xrayFile.existsSync()) {
      try {
        final ByteData data = await rootBundle.load('assets/windows/xray.exe');
        final List<int> bytes =
            data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
        await xrayFile.writeAsBytes(bytes);
      } catch (e) {
        throw Exception("Failed to copy Xray executable: $e");
      }
    }
  }

  static Future<void> _copyConfigFile(File configFile) async {
    if (!configFile.existsSync()) {
      try {
        final ByteData data =
            await rootBundle.load('assets/windows/config.json');
        final List<int> bytes =
            data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
        await configFile.writeAsBytes(bytes);
      } catch (e) {
        throw Exception("Failed to copy config file: $e");
      }
    }
  }

  static Future<void> _runXray(File xrayFile, File configFile) async {
    try {
      _xrayProcess =
          await Process.start(xrayFile.path, ['-config', configFile.path]);
      print('Xray started. PID: ${_xrayProcess?.pid}');

      _xrayProcess?.stdout.transform(utf8.decoder).listen((data) {
        print('Xray stdout: $data');
      });
      _xrayProcess?.stderr.transform(utf8.decoder).listen((data) {
        print('Xray stderr: $data');
      });
    } catch (e) {
      throw Exception("Failed to run Xray process: $e");
    }
  }

  static Future<void> stopXray() async {
    if (_xrayProcess != null) {
      try {
        _xrayProcess!.kill();
        _xrayProcess = null;
        print('Xray stopped');
      } catch (e) {
        print('Error stopping Xray: $e');
        throw Exception("Failed to stop Xray: $e");
      }
    } else {
      print('Xray was not running');
    }
  }

  static Future<bool> isXrayRunning() async {
    if (_xrayProcess == null) return false;
    try {
      return _xrayProcess!.exitCode.then((_) => false).timeout(
            Duration(milliseconds: 100),
            onTimeout: () => true,
          );
    } catch (e) {
      print("Error checking if Xray is running: $e");
      return false;
    }
  }
}
