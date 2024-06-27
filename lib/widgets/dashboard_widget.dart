import 'package:flutter/material.dart';
import 'package:segment/util/responsive.dart';
import 'package:segment/widgets/connect_widget.dart';
import 'package:segment/widgets/header_widget.dart';
import 'package:segment/widgets/line_chart_card.dart';
import 'package:segment/widgets/logs_widget.dart';
import 'package:segment/widgets/side_menu_widget.dart';

class DashboardWidget extends StatefulWidget {
  const DashboardWidget({super.key});

  @override
  _DashboardWidgetState createState() => _DashboardWidgetState();
}

class _DashboardWidgetState extends State<DashboardWidget> {
  Widget? endDrawerContent;

  void showConnectionDetails() {
    setState(() {
      endDrawerContent = LogsWidget();
    });
    Scaffold.of(context).openEndDrawer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: SideMenuWidget(),
      ),
      endDrawer: Drawer(
        child: endDrawerContent ?? Center(child: Text("Select an item")),
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Column(
                children: [
                  Builder(
                    builder: (context) => Padding(
                      padding: const EdgeInsets.only(top: 18),
                      child: HeaderWidget(
                        onLocationIconTapped: showConnectionDetails,
                      ),
                    ),
                  ),
                  Spacer(),
                  Center(
                    child: ConnectionCard(),
                  ),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 18),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: LineChartCard(),
                    ),
                  ),
                  const SizedBox(height: 18),
                  if (Responsive.isTablet(context))
                    Padding(
                      padding: const EdgeInsets.only(bottom: 18),
                      child: LogsWidget(),
                    ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
