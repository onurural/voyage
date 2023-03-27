
import 'package:flutter/material.dart';

import 'GradientIcon.dart';

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
        size: 40,
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
    const Icon(Icons.home, color: Colors.white, size: 40),
    const Icon(Icons.calendar_month_rounded, color: Colors.white, size: 40),
    const Icon(Icons.add_circle_rounded, color: Colors.white, size: 40),
    const Icon(Icons.document_scanner, color: Colors.white, size: 40),
    const Icon(Icons.account_circle, color: Colors.white, size: 40),
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
        child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),child: Container(
          padding: const EdgeInsets.fromLTRB(0, 12, 0, 12),
          width: double.infinity,
          decoration: BoxDecoration(
              border: Border.all(width: 1, color: Colors.black),
              color: const Color.fromRGBO(44, 87, 116, 100),
              borderRadius: BorderRadius.circular(25)),
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
        ),
    );
  }
}