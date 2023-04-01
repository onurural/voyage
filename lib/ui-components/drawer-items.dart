import 'package:flutter/material.dart';

class DrawerItem {
  final String title;
  final IconData icon;
  final Widget widget;

  DrawerItem({
    required this.title,
    required this.icon,
    required this.widget,
  });
}

class DrawerItems {
  static final profile = DrawerItem(
    title: 'John Doe',
    icon: Icons.person,
    widget: Container(
      height: 120,
      color: Colors.blue,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            CircleAvatar(
              radius: 30,
              backgroundImage: AssetImage('assets/profile_image.jpg'),
            ),
            SizedBox(height: 10),
            Text(
              'Obada Qasem',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    ),
  );

  static final home = DrawerItem(
    title: 'Home',
    icon: Icons.home,
    widget: const Center(
      child: Text(
        'Home',
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );

  static final settings = DrawerItem(
    title: 'Settings',
    icon: Icons.settings,
    widget: const Center(
      child: Text(
        'Settings',
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );

  static final logout = DrawerItem(
    title: 'Logout',
    icon: Icons.logout,
    widget: const Center(
      child: Text(
        'Logout',
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );

  static final dashboard = DrawerItem(
    title: 'Dashboard',
    icon: Icons.dashboard,
    widget: const Center(
      child: Text(
        'Dashboard',
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );

  static final search = DrawerItem(
    title: 'Search',
    icon: Icons.search,
    widget: const Center(
      child: Text(
        'Search',
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );

  static final notifications = DrawerItem(
    title: 'Notifications',
    icon: Icons.notifications,
    widget: const Center(
      child: Text(
        'Notifications',
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );

  static final messages = DrawerItem(
    title: 'Messages',
    icon: Icons.message,
    widget: const Center(
      child: Text(
        'Messages',
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );

  static final bookmarks = DrawerItem(
    title: 'Bookmarks',
    icon: Icons.bookmark,
    widget: const Center(
      child: Text(
        'Bookmarks',
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );

  static final help = DrawerItem(
    title: 'Help',
    icon: Icons.help,
    widget: const Center(
      child: Text(
        'Help',
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );

  static final feedback = DrawerItem(
    title: 'Feedback',
    icon: Icons.feedback,
    widget: const Center(
      child: Text(
        'Feedback',
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );

  static final about = DrawerItem(
    title: 'About',
    icon: Icons.info,
    widget: const Center(
      child: Text(
        'About',
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );

  static final privacyPolicy = DrawerItem(
    title: 'Privacy Policy',
    icon: Icons.privacy_tip,
    widget: const Center(
      child: Text(
        'Privacy Policy',
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );

  static final termsOfService = DrawerItem(
    title: 'Terms of Service',
    icon: Icons.article,
    widget: const Center(
      child: Text(
        'Terms of Service',
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );

  static final helpCenter = DrawerItem(
    title: 'Help Center',
    icon: Icons.help_center,
    widget: const Center(
      child: Text(
        'Help Center',
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );

  static final all = [
    profile,
    home,
    dashboard,
    search,
    notifications,
    messages,
    bookmarks,
    settings
  ];
}
