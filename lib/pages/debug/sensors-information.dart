import 'package:flutter/material.dart';
import 'package:sensors/sensors.dart';

import 'package:throw_it/sensors/rotation_vector.dart';

class SensorsInformation extends StatelessWidget {

	@override
	Widget build(BuildContext context) {

		return Column(
			mainAxisSize: MainAxisSize.max,
			children: [
				SensorsStreamAxisInformation(
					"Rotation Information",
					RotationVector.events
				),
				SensorsStreamAxisInformation(
					"Accelerometer Information",
					userAccelerometerEvents
				),
				Expanded(
					child: SmartphoneRotation()
				)
			]
		);
	}
}

class SmartphoneRotation extends StatelessWidget {

	Widget build(BuildContext context) {

		return StreamBuilder(
			stream: RotationVector.events,
			builder: (context, snapshot) {

				if (!snapshot.hasData) {
					return _LoadingWidget(
						title: 'Rotation Information'
					);
				}

				var event = snapshot.data;
				var screenSize = MediaQuery.of(context).size;
				return Center(
					child: Transform(
						transform: Matrix4
							.identity()
							..setEntry(3, 2, 0.001)
							..setRotationX(event.x * 0.1)
							..setRotationY(event.y * 0.1)
							..setRotationZ(event.z * 0.1),
						child: Container(
							height: screenSize.height * 0.25,
							width: screenSize.width * 0.25,
							color: Colors.lightGreenAccent
						)
					)
				);
			}
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
					return _LoadingWidget(
						title: this.title
					);
				}

				var event = snapshot.data;
				return _sensorDataWidget(event);
			}
		);
	}

	Widget _sensorDataWidget(event) {

		return Container(
			margin: EdgeInsets.only(
				bottom: 8
			),
			child: Column(
				mainAxisSize: MainAxisSize.min,
				children: <Widget>[
					Text(
						this.title,
						style: TextStyle(
							fontSize: 16
						),
					),
					_axisInfo('X', event.x),
					_axisInfo('Y', event.y),
					_axisInfo('Z', event.z)
				],
			)
		);
	}

	Text _axisInfo(String axisName, double value) {

		return Text(
			'$axisName: ${_formatDouble(value)}',
			textAlign: TextAlign.left,
		);
	}

	String _formatDouble(double d) {
		return d.toStringAsFixed(1);
	}
}

class _LoadingWidget extends StatelessWidget {

	final String title;

	_LoadingWidget({@required this.title, Key key}) : super(key: key);

	Widget build(BuildContext context) {

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
}