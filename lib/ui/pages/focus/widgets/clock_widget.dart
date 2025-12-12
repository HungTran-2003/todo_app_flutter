import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/ui/pages/focus/focus_provider.dart';

class ClockWidget extends StatelessWidget {
  final int duration;
  final AnimationController controller;
  const ClockWidget({
    super.key,
    required this.duration,
    required this.controller,
  });

  String get timerString {
    Duration duration = controller.duration! * controller.value;
    return '${(duration.inMinutes).toString().padLeft(2, '0')}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Selector<FocusProvider, bool>(
      selector: (context, provider) => provider.isPlaying,
      builder: (context, isPlaying, child) {
        if (isPlaying) {
          controller.reverse(from: controller.value == 0.0 ? 1.0 : controller.value);
        } else {
          controller.stop();
        }
        return AnimatedBuilder(
          animation: controller,
          builder: (context, child) {
            return Stack(
              alignment: Alignment.center,
              children: <Widget>[
                CustomPaint(
                  size: const Size(300, 300),
                  painter: CirclePainter(
                    animation: controller,
                    backgroundColor: Colors.grey[300]!,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                Text(
                  timerString,
                  style: const TextStyle(fontSize: 70, fontWeight: FontWeight.bold),
                ),
                Positioned(
                  bottom: 50,
                  child: FloatingActionButton(
                    onPressed: (){
                      context.read<FocusProvider>().changeFocus();
                    },
                    child: Icon(isPlaying ? Icons.pause : Icons.play_arrow),
                  ),
                )
              ],
            );
          },
        );
      },
    );
  }
}

class CirclePainter extends CustomPainter {
  final Animation<double> animation;
  final Color backgroundColor, color;

  CirclePainter({
    required this.animation,
    required this.backgroundColor,
    required this.color,
  }) : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = backgroundColor
      ..strokeWidth = 10.0
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    canvas.drawCircle(size.center(Offset.zero), size.width / 2.0, paint);
    paint.color = color;
    double progress = (1.0 - animation.value) * 2 * pi;
    canvas.drawArc(Offset.zero & size, pi * 1.5, -progress, false, paint);
  }

  @override
  bool shouldRepaint(CirclePainter oldDelegate) {
    return animation.value != oldDelegate.animation.value ||
        color != oldDelegate.color ||
        backgroundColor != oldDelegate.backgroundColor;
  }
}
