import 'package:segment/util/responsive.dart';
import 'package:flutter/material.dart';

class HeaderWidget extends StatelessWidget {
  final VoidCallback onLocationIconTapped;

  const HeaderWidget({
    super.key,
    required this.onLocationIconTapped,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double dropdownWidth = Responsive.isDesktop(context)
        ? screenWidth * (7 / 12) - 130
        : screenWidth - 64 - 100;

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
              child: DropdownMenu(
                label: const Text("Select The Server"),
                enableFilter: true,
                enableSearch: true,
                width: dropdownWidth,
                dropdownMenuEntries: <DropdownMenuEntry<String>>[
                  DropdownMenuEntry(value: "1", label: "server 1 "),
                  DropdownMenuEntry(value: "2", label: "server 2"),
                  DropdownMenuEntry(value: "3", label: "server 3"),
                  DropdownMenuEntry(value: "4", label: "server 4"),
                  DropdownMenuEntry(value: "5", label: "server 5"),
                ],
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
  }
}
