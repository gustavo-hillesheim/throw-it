import 'package:flutter/material.dart';

import 'package:throw_it/pages/debug/sensors_information.dart';
import 'package:throw_it/components/action-button.dart';

class DebugPage extends StatelessWidget {

	@override
	Widget build(BuildContext context) {

		return Scaffold(
			body: SafeArea(
				child: Column(
					mainAxisSize: MainAxisSize.max,
					children: [
						Expanded(
							flex: 8,
							child: SensorsInformation()
						),
						_goBackButton(context)
					]
				)
			),
		);
	}

	Widget _goBackButton(BuildContext context) {

		return Expanded(
			flex: 3,
			child: ActionButton(
				text: 'Go back',
				onPressed: () {
					Navigator.pop(context);
				},
			)
		);
	}
}