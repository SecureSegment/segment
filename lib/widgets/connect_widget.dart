import 'package:flutter/material.dart';

class ConnectionCard extends StatefulWidget {
  const ConnectionCard({super.key});

  @override
  _ConnectionCardState createState() => _ConnectionCardState();
}

class _ConnectionCardState extends State<ConnectionCard> {
  bool isConnected = false;
  String status = "Tap To Connect";
  void toggleConnection() {
    setState(() {
      isConnected = !isConnected;
      status = isConnected ? "Connected" : "Tap To Connect";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 200,
            height: 60,
            child: ElevatedButton(
              onPressed: toggleConnection,
              child: Text(
                isConnected ? 'Disconnect' : 'Connect',
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
                color: isConnected ? Colors.green : Colors.red,
              ),
              const SizedBox(width: 8),
              Text(status),
            ],
          ),
        ],
      ),
    );
  }
}
