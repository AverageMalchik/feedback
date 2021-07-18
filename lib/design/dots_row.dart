import 'package:flutter/material.dart';

class Dots extends StatelessWidget {

  final bool focus;
  Dots({required this.focus});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInExpo,
        height: focus ? 14 : 10,
        width: focus ? 14 : 10,
        child: CircleAvatar(
          backgroundColor: focus ? Colors.black : Colors.white,
        ),
      ),
    );
  }
}

