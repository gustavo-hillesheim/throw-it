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
					RotationVector.events(degrees: true)
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
			stream: RotationVector.events(),
			builder: (context, snapshot) {

				if (!snapshot.hasData) {
					return _LoadingWidget(
						title: 'Rotation Information'
					);
				}

				RotationVectorEvent event = snapshot.data;
				Size screenSize = MediaQuery.of(context).size;

				return SizedBox(
					height: screenSize.height * 0.25,
					width: screenSize.width * 0.25,
					child: Transform(
						alignment: Alignment.center,
						transform: Matrix4
							.identity()
							..rotateX(event.x)
							..rotateY(event.y)
							..rotateZ(event.z),
						child: _Device()
					)
				);
			}
		);
	}
}

class _Device extends StatelessWidget {

	@override
	Widget build(BuildContext context) {

		return Column(
			children: [
				Expanded(
					child: Row(
						children: [
							_box(Colors.yellow),
							_box(Colors.red)
						]
					)
				),
				Expanded(
					child: Row(
						children: [
							_box(Colors.blue),
							_box(Colors.green)
						]
					)
				)
			]
		);
	}

	Widget _box(Color color) {

		return Expanded(
			child: Container(
					color: color
			)
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
			'$axisName: ${value}',
			textAlign: TextAlign.left,
		);
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