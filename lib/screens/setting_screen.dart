import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/server_manager.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Consumer<ServerManager>(
        builder: (context, serverManager, child) {
          return ListView(
            children: [
              ListTile(
                title: Text('Selected Server'),
                subtitle: Text(serverManager.selectedServer),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Select Server'),
                        content: DropdownButton<String>(
                          value: serverManager.selectedServer,
                          items: serverManager.servers
                              .map((String server) => DropdownMenuItem<String>(
                                    value: server,
                                    child: Text(server),
                                  ))
                              .toList(),
                          onChanged: (String? newValue) {
                            if (newValue != null) {
                              serverManager.selectServer(newValue);
                              Navigator.of(context).pop();
                            }
                          },
                        ),
                      );
                    },
                  );
                },
              ),
              // Add more settings options here
            ],
          );
        },
      ),
    );
  }
}
