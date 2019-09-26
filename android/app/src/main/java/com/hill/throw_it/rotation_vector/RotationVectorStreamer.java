package com.hill.throw_it.rotation_vector;

import io.flutter.plugin.common.EventChannel;

class RotationVectorStreamer implements RotationVectorListener {


	private EventChannel.EventSink eventSink;

	RotationVectorStreamer(EventChannel.EventSink eventSink) {

		this.eventSink = eventSink;
	}

	@Override
	public void onChange(float pitch, float roll, float azimuth) {

		this.eventSink.success();
	}
}
