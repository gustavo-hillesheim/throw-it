import 'package:flutter/material.dart';

import './sensors-information.dart';
import 'package:throw_it/components/action-button.dart';

class ThrowingPage extends StatelessWidget {

	@override
	Widget build(BuildContext context) {

		return Scaffold(
			body: Column(
				mainAxisSize: MainAxisSize.max,
				children: <Widget>[
					SensorsInformation(),
					Expanded(
						flex: 3,
						child: ActionButton(
							text: 'Go back',
							onPressed: () {
								Navigator.pop(context);
							}
						)
					)
				],
			)
		);
	}
}