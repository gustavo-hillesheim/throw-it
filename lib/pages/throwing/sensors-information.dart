import 'package:flutter/material.dart';
import 'package:sensors/sensors.dart';

class SensorsInformation extends StatelessWidget {

	@override
	Widget build(BuildContext context) {

		return Column(
			children: [
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