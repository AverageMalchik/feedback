import 'package:flutter/material.dart';

class ClipperWave extends CustomClipper<Path> {

  final List<Offset> waveList;
  ClipperWave({required this.waveList});

  @override
  getClip(Size size) {
    final Path path = Path();
    path.lineTo(0,size.height*5/8);
    path.addPolygon(waveList, false);
    path.lineTo(size.width, 0);
    path.lineTo(0,0);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper oldClipper) {
    return true;
  }
  
}