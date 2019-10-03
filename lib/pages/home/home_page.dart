import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' as Foundation;

import 'package:throw_it/components/action-button.dart';

class HomePage extends StatelessWidget {

	@override
	Widget build(BuildContext context) {

		return SafeArea(
			child: Scaffold(
				resizeToAvoidBottomInset: false,
				body: Column(
					mainAxisSize: MainAxisSize.max,
					children: [
						Expanded(
							child: _Title()
						),
						Expanded(
							child: _Buttons()
						)
					]
				)
			)
		);
	}
}

class _Buttons extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _navigationButton(
          context: context,
          text: 'Send message',
          route: '/send-message'
        ),
        Container(height: 16),
        _navigationButton(
          context: context,
          text: 'Message history',
          route: '/message-history'
        ),
        Container(height: 16),
        Foundation.kReleaseMode ? null :
        _navigationButton(
          context: context,
          text: 'Debug sensors',
          route: '/debug'
        )
      ]
    );
  }

  Widget _navigationButton({BuildContext context, String text, String route}) {
    return ActionButton(
      text: text,
      onPressed: () => Navigator.pushNamed(context, route)
    );
  }
}

class _Title extends StatelessWidget {

	@override
	Widget build(BuildContext context) {

		return Center(
			child: Text(
				'Throw It',
				style: TextStyle(
					fontSize: 48
				)
			)
		);
	}
}