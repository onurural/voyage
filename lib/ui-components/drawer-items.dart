import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';

class DrawerItem {
  final String title;
  final IconData icon;
  final Widget? widget;

  DrawerItem({
    required this.title,
    required this.icon,
    required this.widget,
  });
}

class DrawerItems {
  static final profile = DrawerItem(
   
    widget: Container(
      height: 120,

      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:  [
            CircleAvatar(
              backgroundColor: Colors.transparent,
              radius: 30,
              backgroundImage: AssetImage('assets/Images/default_profile_picture.png'),
            ),
            SizedBox(height: 10),
            Text(
              'Obada Qasem',
              style: GoogleFonts.poppins(
                textStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                )
              )
            ),
            Divider(
              color: Colors.white,
              thickness: 3,
            ),
          ],
        ),
      ),
    ), title: 'profile', icon: Icons.account_circle,
  );

  static final home = DrawerItem(
    title: 'Home',
    icon: Icons.home,
    widget: null
  );

  static final settings = DrawerItem(
    title: 'Settings',
    icon: Icons.settings,
    widget:null
  );

  static final logout = DrawerItem(
    title: 'Log Out',
    icon: Icons.logout,
    widget: null
  );

  static final helpAndFaq = DrawerItem(
    title: 'Help & FAQ',
    icon: Icons.help,
    widget: null
  );

  static final pp = DrawerItem(
    title: 'Privacy Policies',
    icon: Icons.privacy_tip_sharp,
    widget: null,
  );

  static final notifications = DrawerItem(
    title: 'Notifications',
    icon: Icons.notifications,
    widget: null
  );

  static final contactUs = DrawerItem(
    title: 'Contact Us',
    icon: Icons.call,
    widget: null
  );



  static final termsOfService = DrawerItem(
    title: 'Terms of Service',
    icon: Icons.article,
    widget: null
  );



  static final all = [
    profile,
    home,
    notifications,
    settings,
    pp,
    termsOfService,
    contactUs,
    logout
  ];
}
