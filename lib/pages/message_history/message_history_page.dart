import 'package:flutter/material.dart';

import 'package:throw_it/components/action-button.dart';

class MessageHistoryPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 8,
              child: Center(
                child: Text('Not implemented. Yet...')
              )
            ),
            _goBackButton(context)
          ]
        )
      )
    );
  }

  Widget _goBackButton(BuildContext context) {

    return Expanded(
        flex: 3,
        child: ActionButton(
          text: 'Go back',
          onPressed: () {
            Navigator.of(context).pop();
          },
        )
    );
  }
}