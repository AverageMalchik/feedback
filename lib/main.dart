import 'package:feedback/pages/carousel_main.dart';
import 'package:feedback/pages/result.dart';
import 'package:flutter/material.dart';

void main() =>
    runApp(MaterialApp(
      initialRoute: '/',
      //implement onGenerateRoute for page transitions
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/': return MaterialPageRoute(builder: (_) => CarouselMain());
          case '/result':
            return PageRouteBuilder(
                settings: settings, // Pass this to make popUntil(), pushNamedAndRemoveUntil(), works
                pageBuilder: (context,animation,secondaryAnimation) => Result(),
                transitionsBuilder: (context,animation,secondaryAnimation,child) {
                  var begin = Offset(0.0, 2.0);
                  var end = Offset.zero;
                  var curve = Curves.ease;

                  var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                  return SlideTransition(
                    position: animation.drive(tween),
                    child: child,
                  );
                },
            );
        }
      },
    ));

