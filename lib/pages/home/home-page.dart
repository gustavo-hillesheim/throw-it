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
							flex: 4,
							child: _Title()
						),
						Expanded(
							flex: 4,
							child: _InputText()
						),
						_throwItButton(context)
					]
				),
				floatingActionButton: _debugButton(context),
			)
		);
	}

	Widget _throwItButton(BuildContext context) {

		return Expanded(
			flex: 3,
			child: ActionButton(
				text: 'Throw it now!',
				onPressed: () {
					Navigator.pushNamed(context, '/throwing');
				}
			)
		);
	}

	Widget _debugButton(BuildContext context) {

		if (Foundation.kReleaseMode) {
			return null;
		} else {
			return _DebugButton();
		}
	}
}

class _DebugButton extends StatelessWidget {

	Widget build(BuildContext context) {

		return Container(
			decoration: _decoration(),
			child: IconButton(
				icon: Icon(Icons.settings),
				onPressed: () {
					Navigator.pushNamed(context, '/debug');
				},
				tooltip: 'Debug sensors',
			)
		);
	}

	BoxDecoration _decoration() {

		return BoxDecoration(
			borderRadius: BorderRadius.all(Radius.circular(32)),
			color: Colors.lightGreenAccent[400],
			boxShadow: [
				BoxShadow(
					offset: Offset(0, 4),
					blurRadius: 4,
					color: Colors.grey
				)
			]
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