import 'package:flutter/services.dart';
import 'dart:async';

class RotationVector {

	static final _stream = EventChannel('io.hill.rotation_vector/stream');

	static Stream get events {
		return _stream
			.receiveBroadcastStream()
			.map(_convertInputToRotationVectorEvent);
	}

	//TODO: Implementar real oficial
	static RotationVectorEvent instant() {

		return _convertInputToRotationVectorEvent({});
	}

	static RotationVectorEvent _convertInputToRotationVectorEvent(input) {

		return RotationVectorEvent(
			x: input['x'],
			y: input['y'],
			z: input['z']
		);
	}
}

class RotationVectorEvent {

	final double z;
	final double x;
	final double y;

	RotationVectorEvent({this.z, this.x, this.y});
}

typedef OnRotationVectorEvent = void Function(RotationVectorEvent event);