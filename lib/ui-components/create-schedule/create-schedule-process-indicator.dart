import 'dart:math';
import 'package:flutter/material.dart';

class UniqueProgressIndicator extends StatefulWidget {
  final double value;

  UniqueProgressIndicator(this.value);

  @override
  _UniqueProgressIndicatorState createState() => _UniqueProgressIndicatorState();
}

class _UniqueProgressIndicatorState extends State<UniqueProgressIndicator> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    )..repeat();

    _animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 20,
      child: CustomPaint(
        painter: _UniqueProgressPainter(
          value: widget.value,
          animation: _animation,
        ),
      ),
    );
  }
}

class _UniqueProgressPainter extends CustomPainter {
  final double value;
  final Animation<double> animation;

  _UniqueProgressPainter({required this.value, required this.animation}) : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint backgroundPaint = Paint()
      ..color = Colors.grey.shade300
      ..style = PaintingStyle.fill;

    final Paint progressPaint = Paint()
      ..shader = LinearGradient(
        colors: [Colors.blue.shade700, Colors.blue.shade300],
        stops: [
          animation.value * 0.5,
          min(animation.value * 1.5, 1.0),
        ],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height))
      ..style = PaintingStyle.fill;

    final double progressWidth = size.width * value;
    final double borderRadius = size.height / 2;

    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 0, size.width, size.height),
        Radius.circular(borderRadius),
      ),
      backgroundPaint,
    );

    canvas.saveLayer(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Paint(),
    );

    Path wavePath = Path();
    for (int i = 0; i < progressWidth.toInt(); i++) {
      double waveHeight = sin((i / 20) + (animation.value * 2 * pi)) * 5;
      wavePath.lineTo(i.toDouble(), waveHeight + size.height / 2);
    }
    wavePath.lineTo(progressWidth, size.height);
    wavePath.lineTo(0, size.height);
    wavePath.close();

    canvas.clipPath(wavePath);
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(
          0,
          0,
          progressWidth,
          size.height,
        ),
        Radius.circular(borderRadius),
      ),
      progressPaint,
    );

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant _UniqueProgressPainter oldDelegate) => oldDelegate.value != value || oldDelegate.animation != animation;
}
