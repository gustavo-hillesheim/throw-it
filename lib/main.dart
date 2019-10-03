import 'package:flutter/material.dart';

import 'package:throw_it/pages/home/home_page.dart';
import 'package:throw_it/pages/send_message/send_message_page.dart';
import 'package:throw_it/pages/message_history/message_history_page.dart';
import 'package:throw_it/pages/debug/debug_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Throw It',
      routes: {
        '/': (context) => HomePage(),
        '/send-message': (context) => SendMessagePage(),
        '/message-history': (context) => MessageHistoryPage(),
        '/debug': (context) => DebugPage()
      },
      theme: ThemeData(
        primaryColor: Colors.deepOrange[400],
        accentColor: Colors.white
      ),
    );
  }
}