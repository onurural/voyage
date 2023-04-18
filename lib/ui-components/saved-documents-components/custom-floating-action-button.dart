import 'dart:math' as math;
import 'package:flutter/material.dart';

class CustomFloatingActionButton extends StatefulWidget {
  final VoidCallback onPressed;

  const CustomFloatingActionButton({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  @override
  _CustomFloatingActionButtonState createState() =>
      _CustomFloatingActionButtonState();
}

class _CustomFloatingActionButtonState
    extends State<CustomFloatingActionButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );

    _animationController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressed,
      child: Stack(
        alignment: Alignment.center,
        children: [
          AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              return CustomPaint(
                painter: GlowingPainter(
                  progress: _animation.value,
                  color: Color.fromRGBO(37, 154, 180, 100).withOpacity(0.3),
                ),
                size: Size(56 + _animation.value * 40, 56 + _animation.value * 40),
              );
            },
          ),
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(28),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color.fromRGBO(37, 154, 180, 100).withOpacity(0.9),
                 Colors.grey
                ],
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  spreadRadius: 1,
                  blurRadius: 8,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: const Center(
              child: Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class GlowingPainter extends CustomPainter {
  final double progress;
  final Color color;

  GlowingPainter({required this.progress, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    double radius = math.min(size.width, size.height) / 2;
    final paint = Paint()
      ..color = color.withOpacity(0.6 - progress * 0.6)
      ..style = PaintingStyle.fill;

    canvas.drawCircle(
        Offset(size.width / 2, size.height / 2),
        radius * (1 + progress * 0.5),
        paint);
  }

  @override
  bool shouldRepaint(GlowingPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
