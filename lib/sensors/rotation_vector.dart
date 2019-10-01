import 'package:flutter/services.dart';
import 'dart:async';
import 'dart:math';

class RotationVector {

	static final _stream = EventChannel('io.hill.rotation_vector/stream');
	static Stream _broadcastStream;

	static Stream<RotationVectorEvent> events({degrees = false}) {
		if (_broadcastStream == null) {
			_broadcastStream = _stream.receiveBroadcastStream();
		}
		return _broadcastStream
				.map(_inputToRotationVectorEvent(degrees: degrees));
	}

	//TODO: Implementar real oficial
	static RotationVectorEvent instant() {
		return _inputToRotationVectorEvent()(null);
	}

	static _inputToRotationVectorEvent({degrees = false}) => (input) {

		if (input == null)
			return null;

		double x = input['x'];
		double y = input['y'];
		double z = input['z'];

		if (degrees) {
			x *= pi / 180;
			y *= pi / 180;
			z *= pi / 180;
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