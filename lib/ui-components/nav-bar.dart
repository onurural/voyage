// ignore_for_file: file_names

import 'package:flutter/material.dart';

import 'gradient-icon.dart';

class NavBar extends StatefulWidget {
  final void Function(int index) onTap;

  const NavBar({Key? key, required this.onTap}) : super(key: key);

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int _selectedIndex = 0;
  List<Widget> _gradientIcons = [];
  List<Widget> _icons = [];

  void selectScreen(int index) {
    setState(() {
      _selectedIndex = index;
      widget.onTap(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    double iconSize = MediaQuery.of(context).size.width / 10;
    double bigIconSize = MediaQuery.of(context).size.width /7.7;
    _gradientIcons = [
      GradientIcon(
          icon: Icons.home,
          size: iconSize,
          gradient: const LinearGradient(
              colors: [Color.fromRGBO(37, 154, 180, 100), Colors.black],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter)),
      GradientIcon(
          icon: Icons.calendar_month,
          size: iconSize,
          gradient: const LinearGradient(
              colors: [Color.fromRGBO(37, 154, 180, 100), Colors.black],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter)),
      GradientIcon(
          icon: Icons.add_circle_outlined,
          size: bigIconSize,
          gradient: const LinearGradient(
              colors: [Color.fromRGBO(37, 154, 180, 100), Colors.black],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter)),
      GradientIcon(
          icon: Icons.document_scanner,
          size: iconSize,
          gradient: const LinearGradient(
              colors: [Color.fromRGBO(37, 154, 180, 100), Colors.black],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter)),
      GradientIcon(
          icon: Icons.account_circle,
          size: iconSize,
          gradient: const LinearGradient(
              colors: [Color.fromRGBO(37, 154, 180, 100), Colors.black],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter)),
    ];

    _icons = [
      Icon(Icons.home, color: const Color.fromRGBO(44, 87, 116, 100), size: iconSize),
      Icon(Icons.calendar_month_rounded, color: const Color.fromRGBO(44, 87, 116, 100), size: iconSize),
      Icon(Icons.add_circle_rounded, color: const Color.fromRGBO(44, 87, 116, 100), size: bigIconSize),
      Icon(Icons.document_scanner, color: const Color.fromRGBO(44, 87, 116, 100), size: iconSize),
      Icon(Icons.account_circle, color: const Color.fromRGBO(44, 87, 116, 100), size: iconSize),
    ];

    return Center(
      child: Container(
        decoration: const BoxDecoration(color: Colors.white),
        padding: const EdgeInsets.fromLTRB(0, 12, 0, 12),
        width: double.infinity,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            for (int i = 0; i < _icons.length; i++)
              Expanded(
                child: MaterialButton(
                  onPressed: () {
                    selectScreen(i);
                  },
                  child: AnimatedCrossFade(
                    firstChild: _icons[i],
                    secondChild: _gradientIcons[i],
                    crossFadeState: _selectedIndex == i
                        ? CrossFadeState.showSecond
                        : CrossFadeState.showFirst,
                    duration: const Duration(milliseconds: 500),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}