import 'package:flutter/material.dart';
import 'dart:math' as Math;

import 'clipper_wave.dart';

class Wave extends StatefulWidget {

  final Color? color;
  final double fixedWidth;
  final double height;
  final double opacityWave;
  final double waveHeight;
  final double factor;
  final double speed;

  Wave({
    required this.color,
    required this.fixedWidth,
    required this.height,
    required this.opacityWave,
    required this.waveHeight,
    required this.factor,
    required this.speed
});

  @override
  _WaveState createState() => _WaveState();
}

class _WaveState extends State<Wave> with SingleTickerProviderStateMixin{

  late AnimationController _controller;
  List<Offset> wavePoints = [];

  @override
  void initState() {
    _controller = AnimationController(vsync: this,duration: Duration(seconds: 2))
    ..addListener(() {
      wavePoints.clear();

      final double waveSpeed = _controller.value * widget.speed;
      final double fullSphere = _controller.value * Math.pi * 2;
      final normalizer = Math.cos(fullSphere);
      final double waveWidth = Math.pi / widget.factor;

      for (int i = 0; i <=widget.fixedWidth.toInt(); ++i) {
        double calc = Math.sin((waveSpeed-i) * waveWidth);
        wavePoints.add(
          Offset(
            i.toDouble(), //X
            calc * widget.waveHeight * normalizer + widget.height*.75, //Y
          ),
        );
      }
    });
    _controller.repeat();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context,_) {
        return ClipPath(
          clipper: ClipperWave(waveList: wavePoints),
          child: Opacity(
            opacity: widget.opacityWave,
            child: Container(
              height: widget.height,
              width: widget.fixedWidth,
              color: widget.color,
            ),
          ),
        );
      },
    );
  }
}
