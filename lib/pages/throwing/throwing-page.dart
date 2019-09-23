import 'package:flutter/material.dart';
import 'package:sensors/sensors.dart';
import 'package:flutter_compass/flutter_compass.dart';

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

class SensorsInformation extends StatelessWidget {

	@override
	Widget build(BuildContext context) {

		return Column(
			children: [
				Expanded(
					flex: 4,
					child: CompassInformation()
					/*SensorsStreamAxisInformation(
						"Gyroscope Information",
						gyroscopeEvents
					)*/
				),
				Expanded(
					flex: 4,
					child: SensorsStreamAxisInformation(
						"Accelerometer Information",
						userAccelerometerEvents
					)
				),
			]
		);
	}
}

class CompassInformation extends StatelessWidget {

	@override
	Widget build(BuildContext context) {

		return StreamBuilder(
			stream: FlutterCompass.events,
			builder: (context, AsyncSnapshot<double> snapshot) {

				if (!snapshot.hasData) {
					return Column(
						children: [
							Container(
								margin: EdgeInsets.symmetric(
									vertical: 16
								),
								child: Text('Trying to read Compass Information...')
							),
							LinearProgressIndicator()
						]
					);
				}

				double angle = snapshot.data;
				return Column(
					children: [
						Text(
							'Compass Information',
							style: TextStyle(
								fontSize: 24
							)
						),
						Text('Angle: $angleº')
					]
				);
			},
		);
	}
}

class SensorsStreamAxisInformation extends StatelessWidget {

	final String title;
	final Stream stream;

	SensorsStreamAxisInformation(this.title, this.stream, {Key key}) : super(key: key);

	@override
	Widget build(BuildContext context) {

		return StreamBuilder(
			stream: this.stream,
			builder: (context, snapshot) {

				if (!snapshot.hasData) {
					return Column(
						children: [
							Container(
								margin: EdgeInsets.symmetric(
									vertical: 16
								),
								child: Text('Trying to read ${this.title}...')
							),
							LinearProgressIndicator()
						]
					);
				}

				var event = snapshot.data;
				return Column(
					children: <Widget>[
						Text(
							this.title,
							style: TextStyle(
								fontSize: 24
							),
						),
						Text('X: ${_formatDouble(event.x)}'),
						Text('Y: ${_formatDouble(event.y)}'),
						Text('Z: ${_formatDouble(event.z)}')
					],
				);
			}
		);
	}

	String _formatDouble(double d) {
		return d.abs().toStringAsFixed(1);
	}
}