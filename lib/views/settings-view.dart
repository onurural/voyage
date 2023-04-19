import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animator/flutter_animator.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Settings Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SettingsPage(),
    );
  }
}

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              FadeIn(child: _buildAnimatedText()),
              SizedBox(height: 24),
              _buildSettingsCategory(
                'Profile Settings',
                children: [
                  _buildSettingItem(
                    title: 'Change Email',
                    onTap: () {
                      print('Change Email');
                    },
                  ),
                  _buildSettingItem(
                    title: 'Change Username',
                    onTap: () {
                      print('Change Username');
                    },
                  ),
                  _buildSettingItem(
                    title: 'Change Password',
                    onTap: () {
                      print('Change Password');
                    },
                  ),
                  _buildSettingItem(
                    title: 'Change Phone Number',
                    onTap: () {
                      print('Change Phone Number');
                    },
                  ),
                ],
              ),
              _buildSettingsCategory(
                'App Settings',
                children: [
                  _buildSettingItem(
                    title: 'Clear Cache',
                    onTap: () {
                      print('Clear Cache');
                    },
                  ),
                  _buildSettingItem(
                    title: 'Notifications',
                    onTap: () {
                      print('Notifications');
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAnimatedText() {
    return SizedBox(
      width: 250,
      child: DefaultTextStyle(
        style: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
        child: AnimatedTextKit(
          animatedTexts: [
            TypewriterAnimatedText('Settings'),
          ],
          onTap: () {
            print("Settings");
          },
        ),
      ),
    );
  }

  Widget _buildSettingsCategory(String title, {required List<Widget> children}) {
    return FadeIn(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Text(
              title,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
          ),
          Column(children: children),
        ],
      ),
    );
  }

  Widget _buildSettingItem({required String title, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey.shade300)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 16),
            ),
            Icon(
              Icons.arrow_forward_ios_rounded,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }
}
