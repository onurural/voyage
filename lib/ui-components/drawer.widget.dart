import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:voyage/ui-components/drawer-items.dart';
import 'package:voyage/views/log-in.view.dart';

class DrawerWidget extends StatelessWidget {
  final ValueChanged<DrawerItem> onSelectedItem;

  const DrawerWidget({
    Key? key,
    required this.onSelectedItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 32, 16, 0),
      child: SingleChildScrollView(
          child: Column(
        children: [buildDrawerItems(context)],
      )),
    );
  }

  Widget buildDrawerItems(BuildContext context) {
    return Column(
      children: DrawerItems.all
          .map((item) {
        if (item.widget != null) {
          return item.widget!;
        } else {
          return ListTile(
            contentPadding:
            const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
            leading: Icon(
              item.icon,
              color: Colors.white,
            ),
            title: Text(
              item.title,
              style: GoogleFonts.poppins(
                textStyle:
                const TextStyle(color: Colors.white, fontSize: 17),
              ),
            ),
            onTap: () {
              if(item.title != 'Log Out'){
                onSelectedItem(item);
              }
              else {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LogInScreen()),
                );
              }
            },
          );
        }
      })
          .toList(),
    );
  }
}
