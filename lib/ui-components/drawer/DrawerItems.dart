import 'package:flutter/material.dart';
import '../DrawerItem.dart';

class DrawerItems{
static const home=DrawerItem(title: 'Home', icon: Icons.home);
static const settings=DrawerItem(title: 'Settings', icon:Icons.settings);
static const logout= DrawerItem(title: 'LogOut', icon: Icons.logout);
static final List<DrawerItem> all=[
  home,
  settings,
  logout
];
}