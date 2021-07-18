import 'package:feedback/pages/carousel_main.dart';
import 'package:feedback/pages/result.dart';
import 'package:flutter/material.dart';

void main() =>
    runApp(MaterialApp(
      initialRoute: '/',
      //implement onGenerateRoute for page transitions
      // onGenerateRoute: (settings) {
      //   switch (settings.name) {
      //     case '/': return MaterialPageRoute(builder: (_) => CarouselMain());
      //     case '/result':
      //   }
      // },
      routes: {
        '/': (context) => CarouselMain(),
        '/result': (context) => Result()
      },
    ));

