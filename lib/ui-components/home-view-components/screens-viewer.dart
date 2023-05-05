

// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:voyage/ui-components/drawer-app-bar.dart';


import 'package:voyage/views/notifications.view.dart';
import 'package:voyage/views/privacy-policy.view.dart';
import 'package:voyage/views/settings-view.dart';
import 'package:voyage/views/terms-of-service-page.dart';

import '../../views/contact-us-page.dart';
import '../../views/home-view/home.view.dart';




class ScreenViewer extends StatefulWidget {
  final VoidCallback openDrawer;
  final String index;

  const ScreenViewer(this.openDrawer, this.index, {super.key});

  @override
  State<ScreenViewer> createState() => _ScreenViewerState();
}

class _ScreenViewerState extends State<ScreenViewer> {
Widget activeScreen(){
 switch(widget.index){
   case 'Home':
     return const HomePage();
   case 'Notifications':
     return const NotificationScreen();
   case 'Settings':
     return const SettingsPage();
   case 'Privacy Policies':
     return const PrivacyPolicyPage();
   case 'Terms of Service':
     return const TermsOfServicePage();
   case 'Contact Us':
     return const ContactUsPage();

   default :
     return const HomePage();


 }
}

  @override
  void initState() {
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar:DrawerAppBar(widget.openDrawer),

      body: activeScreen(),
    );
  }
}
