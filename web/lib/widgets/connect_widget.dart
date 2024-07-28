import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/connection_manager.dart';

class ConnectionCard extends StatelessWidget {
  const ConnectionCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ConnectionManager>(
      builder: (context, connectionManager, child) {
        return Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: 200,
                height: 60,
                child: ElevatedButton(
                  onPressed: () async {
                    try {
                      if (connectionManager.isConnected) {
                        await connectionManager.disconnect();
                      } else {
                        await connectionManager.connect();
                      }
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(connectionManager.lastError)),
                      );
                    }
                  },
                  child: Text(
                    connectionManager.isConnected ? 'Disconnect' : 'Connect',
                    style: TextStyle(color: Colors.black),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 248, 244, 231),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(160),
                    ),
                    textStyle: TextStyle(fontSize: 18),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.wifi,
                    color: connectionManager.isConnected
                        ? Colors.green
                        : Colors.red,
                  ),
                  const SizedBox(width: 8),
                  Text(connectionManager.isConnected
                      ? 'Connected: ${connectionManager.connectedTime}'
                      : 'Disconnected'),
                ],
              ),
              if (connectionManager.lastError.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    connectionManager.lastError,
                    style: TextStyle(color: Colors.red),
                    textAlign: TextAlign.center,
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
