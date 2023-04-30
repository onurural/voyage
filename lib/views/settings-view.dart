// ignore_for_file: file_names

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animator/flutter_animator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Settings Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const SettingsPage(),
    );
  }
}

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              FadeIn(child: _buildAnimatedText()),
              const SizedBox(height: 24),
              _buildSettingsCategory(
                'Profile Settings',
                children: [
                  _buildSettingItem(
                    title: 'Change Email',
                    onTap: () {
                    },
                  ),
                  _buildSettingItem(
                    title: 'Change Username',
                    onTap: () {
                    },
                  ),
                  _buildSettingItem(
                    title: 'Change Password',
                    onTap: () {
                    },
                  ),
                  _buildSettingItem(
                    title: 'Change Phone Number',
                    onTap: () {
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
                    },
                  ),
                  _buildSettingItem(
                    title: 'Notifications',
                    onTap: () {
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
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
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
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey.shade300)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 16),
            ),
            const Icon(
              Icons.arrow_forward_ios_rounded,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }
}
