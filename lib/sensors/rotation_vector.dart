import 'package:flutter/services.dart';
import 'dart:async';
import 'dart:math';

class RotationVector {

	static final _stream = EventChannel('io.hill.rotation_vector/stream');
	static Stream _broadcastStream;

	static Stream<RotationVectorEvent> get events {
		if (_broadcastStream == null) {
			_broadcastStream = _stream.receiveBroadcastStream();
		}
		return _broadcastStream.map(_convertInput);
	}

	//TODO: Implementar real oficial
	static RotationVectorEvent instant() {
		return _convertInput(null);
	}

	static RotationVectorEvent _convertInput(input) {

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

	const RotationVectorEvent({this.z, this.x, this.y});
}

typedef OnRotationVectorEvent = void Function(RotationVectorEvent event);