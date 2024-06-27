import 'package:segment/model/menu_model.dart';
import 'package:flutter/material.dart';

class SideMenuData {
  final menu = const <MenuModel>[
    MenuModel(icon: Icons.home, title: 'Home'),
    MenuModel(icon: Icons.person, title: 'Profile'),
    MenuModel(icon: Icons.web, title: 'Configs'),
    MenuModel(icon: Icons.settings, title: 'Settings'),
    MenuModel(icon: Icons.history, title: 'Log History'),
    MenuModel(icon: Icons.info, title: 'About'),
  ];
}
