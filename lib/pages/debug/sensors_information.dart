import 'package:flutter/material.dart';
import 'package:sensors/sensors.dart';
import 'dart:math';

import 'package:throw_it/sensors/rotation_vector.dart';

class SensorsInformation extends StatelessWidget {

	@override
	Widget build(BuildContext context) {

		return Column(
			mainAxisSize: MainAxisSize.max,
			mainAxisAlignment: MainAxisAlignment.spaceBetween,
			children: [
				SensorsStreamAxisInformation(
					"Rotation Information",
					RotationVector.events
						.map(_radiansToDegrees)
				),
				SensorsStreamAxisInformation(
					"Accelerometer Information",
					userAccelerometerEvents
				),
				Center(
					child: SmartphoneRotation()
				)
			]
		);
	}

	RotationVectorEvent _radiansToDegrees(RotationVectorEvent event) {

		double radiansToDegrees = pi / 180;

		double x = event.x * radiansToDegrees;
		double y = event.y * radiansToDegrees;
		double z = event.z * radiansToDegrees;

		return RotationVectorEvent(
			x: x,
			y: y,
			z: z
		);
	}
}

class SmartphoneRotation extends StatelessWidget {

	Widget build(BuildContext context) {

		return StreamBuilder(
			stream: RotationVector.events,
			builder: (context, snapshot) {

				if (snapshot.hasError) {
					return _Error('Rotation Information');
				}

				if (!snapshot.hasData) {
					return _Loading('Rotation Information');
				}

				RotationVectorEvent event = snapshot.data;
				Size screenSize = MediaQuery.of(context).size;

				return _rotatingDevice(event, screenSize);
			}
		);
	}

	Widget _rotatingDevice(event, screenSize) {

		return Transform(
			alignment: Alignment.center,
			transform: Matrix4
				.identity()
				..setEntry(3, 2, 0.006)
				..rotateX(-event.x)
				..rotateY(-event.y)
				..rotateZ(event.z),
			child: Container(
				height: screenSize.height * 0.25,
				width: screenSize.width * 0.25,
				child: _Device()
			)
		);
	}
}

class _Device extends StatelessWidget {

	@override
	Widget build(BuildContext context) {

		return Column(
			mainAxisSize: MainAxisSize.max,
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

		this.stream.listen((e) {}, onError: (e) {
			print('error: $e');
		});

		return StreamBuilder(
			stream: this.stream,
			builder: (context, snapshot) {

				if (snapshot.hasError) {
					return _Error(this.title);
				}

				if (!snapshot.hasData) {
					return _Loading(this.title);
				}

				var event = snapshot.data;
				return _sensorData(event);
			}
		);
	}

	Widget _sensorData(event) {

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
			'$axisName: ${_format(value)}',
			textAlign: TextAlign.left,
		);
	}

	String _format(double value) => value.toStringAsFixed(2);
}

class _Loading extends StatelessWidget {

	final String text;

	const _Loading(this.text);

	@override
	Widget build(BuildContext context) {

		return Column(
			children: [
				Container(
					margin: EdgeInsets.symmetric(
						vertical: 16
					),
					child: Text('Trying to read ${this.text}...')
				),
				LinearProgressIndicator()
			]
		);
	}
}

class _Error extends StatelessWidget {

	final String text;

	const _Error(this.text);

	@override
	Widget build(BuildContext context) {

		return Center(
			child: Column(
				mainAxisAlignment: MainAxisAlignment.center,
				children: [
					Icon(
						Icons.error_outline,
						color: Colors.red,
						size: 32,
					),
					Text(
						'It was not possible to read ${this.text}'
					)
				]
			)
		);
	}
}