import 'package:flutter/material.dart';

import 'package:throw_it/components/action-button.dart';

class HomePage extends StatelessWidget {

	@override
	Widget build(BuildContext context) {

		return Scaffold(
			resizeToAvoidBottomInset: false,
			body: Column(
				mainAxisSize: MainAxisSize.max,
				children: [
					Expanded(
						flex: 4,
						child: Title()
					),
					Expanded(
						flex: 4,
						child: InputText()
					),
					Expanded(
						flex: 3,
						child: ActionButton(
							text: 'Throw it now!',
							onPressed: () {
								Navigator.pushNamed(context, '/throwing');
							}
						)
					)
				]
			)
		);
	}
}

class Title extends StatelessWidget {

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

class InputText extends StatefulWidget {

	_InputTextState createState() => _InputTextState();
}

class _InputTextState extends State<InputText> {

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