import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../util/responsive.dart';
import '../services/server_manager.dart';

class HeaderWidget extends StatelessWidget {
  final VoidCallback onLocationIconTapped;

  const HeaderWidget({
    Key? key,
    required this.onLocationIconTapped,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double dropdownWidth = Responsive.isDesktop(context)
        ? screenWidth * (7 / 12) - 130
        : screenWidth - 64 - 100;

    return Consumer<ServerManager>(
      builder: (context, serverManager, child) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (!Responsive.isDesktop(context))
                InkWell(
                  onTap: () => Scaffold.of(context).openDrawer(),
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Icon(
                      Icons.menu,
                      color: Colors.grey,
                      size: 25,
                    ),
                  ),
                )
              else
                SizedBox(
                  width: 25,
                ),
              Expanded(
                child: Center(
                  child: DropdownButton<String>(
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
                      }
                    },
                    style: TextStyle(color: Colors.white),
                    dropdownColor: Colors.grey[800],
                    isExpanded: true,
                  ),
                ),
              ),
              if (Responsive.isMobile(context))
                InkWell(
                  onTap: onLocationIconTapped,
                  child: Icon(
                    Icons.location_on,
                    color: Colors.grey,
                    size: 25,
                  ),
                )
              else
                SizedBox(
                  width: 25,
                ),
            ],
          ),
        );
      },
    );
  }
}
