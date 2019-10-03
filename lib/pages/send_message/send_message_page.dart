import 'package:flutter/material.dart';

import 'package:throw_it/components/action-button.dart';

class SendMessagePage extends StatelessWidget {

	@override
	Widget build(BuildContext context) {

		return Scaffold(
			body: SafeArea(
				child: Column(
					mainAxisSize: MainAxisSize.max,
					children: <Widget>[
						Expanded(
							flex: 8,
							child: Center(
								child: Text('Not implemented. Yet...'),
							)
						),
						_goBackButton(context)
					],
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
					Navigator.pop(context);
				}
			)
		);
	}
}

class _InputText extends StatefulWidget {
	_InputTextState createState() => _InputTextState();
}

class _InputTextState extends State<_InputText> {

	@override
	Widget build(BuildContext context) {

		return Center(
			child: Padding(
				padding: EdgeInsets.symmetric(
					horizontal: 32
				),
				child: TextField(
					decoration: InputDecoration(
						hintText: 'Write something you wanna throw...'
					),
				)
			)
		);
	}
}