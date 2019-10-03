import 'package:flutter/services.dart';
import 'dart:async';
import 'dart:math';

class RotationVector {

	static final _stream = EventChannel('io.hill.rotation_vector/stream');
	static Stream _broadcastStream;

	static Stream<RotationVectorEvent> events({useDegrees = false}) {
		if (_broadcastStream == null) {
			_broadcastStream = _stream.receiveBroadcastStream();
		}
		return _broadcastStream
				.map(_convertInput(useDegrees));
	}

	//TODO: Implementar real oficial
	static RotationVectorEvent instant() {
		return _convertInput(null);
	}

	static _convertInput(useDegrees) => (input) {

		if (input == null)
			return null;

		double x = input['x'];
		double y = input['y'];
		double z = input['z'];

		if (useDegrees) {
			x *= 180 / pi;
			y *= 180 / pi;
			z *= 180 / pi;
		}

		return RotationVectorEvent(
				x: x,
				y: y,
				z: z
		);
	};
}

class RotationVectorEvent {

	final double z;
	final double x;
	final double y;

	const RotationVectorEvent({this.z, this.x, this.y});
}

typedef OnRotationVectorEvent = void Function(RotationVectorEvent event);