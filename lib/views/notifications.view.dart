// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey[200],
        body: const NotificationScreen(),
      ),
    );
  }
}

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final List<NotificationData> notifications = [
    NotificationData('New message', 'You have a new message from John Doe.', '5 mins ago'),
    NotificationData('Account update', 'Your account has been successfully updated.', '1 hour ago'),
    NotificationData('New connection', 'Jane Smith added you as a connection.', '3 hours ago'),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: notifications.length,
      itemBuilder: (context, index) {
        return Dismissible(
          key: UniqueKey(),
          direction: DismissDirection.horizontal,
          onDismissed: (direction) {
            setState(() {
              notifications.removeAt(index);
            });
          },
          background: Container(
            color: Colors.red,
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.only(left: 20),
            child: const Icon(Icons.delete, color: Colors.white),
          ),
          secondaryBackground: Container(
            color: Colors.red,
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.only(right: 20),
            child: const Icon(Icons.delete, color: Colors.white),
          ),
          child: AnimatedPadding(
            padding: const EdgeInsets.only(left: 0, right: 0),
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeIn,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, spreadRadius: 2),
                ],
              ),
              child: ListTile(
                title: Text(notifications[index].title),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 4),
                    Text(notifications[index].description),
                    const SizedBox(height: 4),
                    Text(notifications[index].time, style: const TextStyle(fontSize: 12, color: Colors.grey)),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class NotificationData {
  final String title;
  final String description;
  final String time;

  NotificationData(this.title, this.description, this.time);
}