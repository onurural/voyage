

import 'package:flutter/material.dart';
import 'package:voyage/ui-components/drawer-app-bar.dart';

import 'package:voyage/views/home-view/home.view.dart';
import 'package:voyage/views/notifications.view.dart';
import 'package:voyage/views/pp-.view.dart';
import 'package:voyage/views/settings-view.dart';
import 'package:voyage/views/terms-of-service-page.dart';

import '../../views/contact-us-page.dart';




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
   case "Home":
     return HomePage();
   case "Notifications":
     return NotificationScreen();
   case "Settings":
     return SettingsPage();
   case "Privacy Policies":
     return PrivacyPolicyPage();
   case "Terms of Service":
     return TermsOfServicePage();
   case "Contact Us":
     return ContactUsPage();

   default :
     return HomePage();


 }
}

  @override
  void initState() {
    // TODO: implement initState
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
