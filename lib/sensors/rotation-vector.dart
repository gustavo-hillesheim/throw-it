import 'package:flutter/services.dart';
import 'dart:async';

class RotationVector {

	static final _stream = EventChannel('io.hill.rotation-vector/stream');

	static Stream get events {
		return _stream
			.receiveBroadcastStream()
			.map(_convertInputToRotationVectorEvent);
	}

	//TODO: Implementar real oficial
	static RotationVectorEvent instant() {

		return _convertInputToRotationVectorEvent(null);
	}

	//TODO: Implementar real oficial
	static RotationVectorEvent _convertInputToRotationVectorEvent(input) {

		return RotationVectorEvent(
			roll: 0,
			pitch: 0,
			azimuth: 0
		);
	}
}

class RotationVectorEvent {

	final double azimuth;
	final double pitch;
	final double roll;

	RotationVectorEvent({this.azimuth, this.pitch, this.roll});
}

typedef OnRotationVectorEvent = void Function(RotationVectorEvent event);