import 'dart:async';
import 'package:flutter/foundation.dart';
import '../xray/xray_service.dart';

class ConnectionManager extends ChangeNotifier {
  bool _isConnected = false;
  Timer? _connectionTimer;
  int _connectedTime = 0;
  String _lastError = '';

  bool get isConnected => _isConnected;
  String get connectedTime =>
      _formatDuration(Duration(seconds: _connectedTime));
  String get lastError => _lastError;

  Future<void> connect() async {
    if (!_isConnected) {
      try {
        await XrayServiceImpl.initializeXray();
        _isConnected = await XrayServiceImpl.isXrayRunning();
        if (_isConnected) {
          _startTimer();
          _lastError = '';
          notifyListeners();
        } else {
          throw Exception("VPN initialized but not running");
        }
      } catch (e) {
        _lastError = "Error connecting to VPN: ${e.toString()}";
        print(_lastError);
        _isConnected = false;
        notifyListeners();
        rethrow;
      }
    }
  }

  Future<void> disconnect() async {
    if (_isConnected) {
      try {
        await XrayServiceImpl.stopXray();
        _isConnected = false;
        _stopTimer();
        _lastError = '';
        notifyListeners();
      } catch (e) {
        _lastError = "Error disconnecting from VPN: ${e.toString()}";
        print(_lastError);
        notifyListeners();
        rethrow;
      }
    }
  }

  void _startTimer() {
    _connectionTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      _connectedTime++;
      notifyListeners();
    });
  }

  void _stopTimer() {
    _connectionTimer?.cancel();
    _connectedTime = 0;
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }

  @override
  void dispose() {
    _connectionTimer?.cancel();
    super.dispose();
  }
}
