import 'package:flutter/material.dart';
import 'package:sensors/sensors.dart';
import 'package:expo_sensors/device_motion.dart';

import 'package:throw_it/components/action-button.dart';

class ThrowingPage extends StatelessWidget {

	@override
	Widget build(BuildContext context) {

		return Scaffold(
			body: Column(
				mainAxisSize: MainAxisSize.max,
				children: <Widget>[
					ExpoSensorsInformation(),
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

class ExpoSensorsInformation extends StatelessWidget {

	@override
	Widget build(BuildContext context) {

		return StreamBuilder(
			stream: DeviceMotion.events,
			builder: (context, AsyncSnapshot<DeviceMotionEvent> snapshot) {

				if (!snapshot.hasData) {
					return Column(
						children: [
							Container(
								margin: EdgeInsets.symmetric(
									vertical: 16
								),
								child: Text('Trying to load sensors information...')
							),
							CircularProgressIndicator()
						]
					);
				}

				var event = snapshot.data;
				return Column(
					children: [
						Expanded(
							child: ExpoSensorsAxisInformation(
								title: 'Gyroscope Information',
								axis: event.rotation
							)
						),
						Expanded(
							child: ExpoSensorsAxisInformation(
								title: 'Accelerometer Information',
								axis: event.acceleration
							)
						)
					]
				);
			}
		);
	}
}

class ExpoSensorsAxisInformation extends StatelessWidget {

	final String title;
	final Map axis;

	ExpoSensorsAxisInformation({this.title, this.axis, Key key}) : super(key: key);

	@override
	Widget build(BuildContext context) {

		return Column(
			children: <Widget>[
				Text(
					this.title,
					style: TextStyle(
						fontSize: 24
					),
				),
				Text('X: ${axis['x']}'),
				Text('Y: ${axis['y']}'),
				Text('Z: ${axis['z']}')
			],
		);
	}

	String _formatDouble(double d) {
		return d.abs().toStringAsFixed(1);
	}
}

class SensorsInformation extends StatelessWidget {

	@override
	Widget build(BuildContext context) {

		return Column(
			children: [
				Expanded(
					flex: 4,
					child: SensorsStreamAxisInformation(
						"Gyroscope Information",
						gyroscopeEvents
					)
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
							CircularProgressIndicator()
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