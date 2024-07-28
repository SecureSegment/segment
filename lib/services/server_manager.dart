import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ServerManager extends ChangeNotifier {
  List<String> _servers = [
    "server 1",
    "server 2",
    "server 3",
    "server 4",
    "server 5"
  ];
  String _selectedServer = "server 1";

  List<String> get servers => _servers;
  String get selectedServer => _selectedServer;

  Future<void> selectServer(String server) async {
    if (_servers.contains(server)) {
      _selectedServer = server;
      notifyListeners();
      await _saveSelectedServer();
    }
  }

  Future<void> loadSelectedServer() async {
    final prefs = await SharedPreferences.getInstance();
    _selectedServer = prefs.getString('selectedServer') ?? _servers[0];
    notifyListeners();
  }

  Future<void> _saveSelectedServer() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('selectedServer', _selectedServer);
  }
}
