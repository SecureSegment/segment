import 'package:flutter/material.dart';
import 'package:segment/const/constant.dart';
import 'package:segment/widgets/flag_widget.dart';
import 'package:segment/widgets/scheduled_widget.dart';
import 'package:segment/widgets/location_details.dart';

class LogsWidget extends StatelessWidget {
  const LogsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: cardBackgroundColor,
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            SizedBox(height: 20),
            Flag(),
            Text(
              'Your IP address: 5.24.25.71',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 16),
            LocationDetails(),
            SizedBox(height: 40),
            Scheduled(),
          ],
        ),
      ),
    );
  }
}
