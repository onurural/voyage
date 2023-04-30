// ignore_for_file: file_names

import 'package:flutter/material.dart';

import 'gradient-icon.dart';

class NavBar extends StatefulWidget {
  final void Function(int index) onTap;

  const NavBar({super.key, required this.onTap});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int _selectedIndex = 0;

  final List<Widget> _gradientIcons = [
    const GradientIcon(
        icon: Icons.home,
        size: 40,
        gradient: LinearGradient(
            colors: [Color.fromRGBO(37, 154, 180, 100), Colors.black],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter)),
    const GradientIcon(
        icon: Icons.calendar_month,
        size: 40,
        gradient: LinearGradient(
            colors: [Color.fromRGBO(37, 154, 180, 100), Colors.black],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter)),
    const GradientIcon(
        icon: Icons.add_circle_outlined,
        size: 50,
        gradient: LinearGradient(
            colors: [Color.fromRGBO(37, 154, 180, 100), Colors.black],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter)),
    const GradientIcon(
        icon: Icons.document_scanner,
        size: 40,
        gradient: LinearGradient(
            colors: [Color.fromRGBO(37, 154, 180, 100), Colors.black],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter)),
    const GradientIcon(
        icon: Icons.account_circle,
        size: 40,
        gradient: LinearGradient(
            colors: [Color.fromRGBO(37, 154, 180, 100), Colors.black],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter)),
  ];

  final List<Widget> _icons = [
    const Icon(Icons.home, color: Color.fromRGBO(44, 87, 116, 100), size: 40),
    const Icon(Icons.calendar_month_rounded, color: Color.fromRGBO(44, 87, 116, 100), size: 40),
    const Icon(Icons.add_circle_rounded, color: Color.fromRGBO(44, 87, 116, 100), size: 50),
    const Icon(Icons.document_scanner, color: Color.fromRGBO(44, 87, 116, 100), size: 40),
    const Icon(Icons.account_circle, color: Color.fromRGBO(44, 87, 116, 100), size: 40),
  ];

  void selectScreen(int index) {
    setState(() {
      _selectedIndex = index;
      widget.onTap(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration:
        const BoxDecoration
          (
          color: Colors.white,
        ),
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
