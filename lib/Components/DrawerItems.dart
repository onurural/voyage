import 'package:flutter/cupertino.dart';
import 'package:voyage/Components/DrawerItem.dart';
import 'package:flutter/material.dart';

class DrawerItems{
static const home=DrawerItem(title: "Home", icon: Icons.home);
static const explore=DrawerItem(title: "Explore", icon: Icons.travel_explore);
static const favourites=DrawerItem(title: "Favourites", icon: Icons.favorite);
static const messages=DrawerItem(title: "messages", icon: Icons.message);
static const profile=DrawerItem(title: "Profile", icon: Icons.account_circle);
static const settings=DrawerItem(title: "Settings", icon:Icons.settings);
static const logout= DrawerItem(title: "LogOut", icon: Icons.logout);
static final List<DrawerItem> all=[
  home,
  explore,
  favourites,
  messages,
  profile,
  settings,
  logout
];
}