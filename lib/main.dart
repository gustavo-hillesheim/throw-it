import 'package:flutter/material.dart';

import 'package:throw_it/pages/home/home-page.dart';
import 'package:throw_it/pages/throwing/throwing-page.dart';
import 'package:throw_it/pages/debug/debug-page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Throw It',
      routes: {
        '/': (context) => HomePage(),
        '/throwing': (context) => ThrowingPage(),
        '/debug': (context) => DebugPage()
      },
    );
  }
}