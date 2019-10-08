package com.hill.throw_it.rotation_vector;

import java.util.HashMap;
import java.util.Map;

import io.flutter.Log;
import io.flutter.plugin.common.EventChannel;

class RotationVectorStreamer implements RotationVectorListener {


	private final String TAG = "RotationVectorStreamer";
	private EventChannel.EventSink eventSink;

	RotationVectorStreamer(EventChannel.EventSink eventSink) {

		this.eventSink = eventSink;
	}

	@Override
	public void onChange(double x, double y, double z) {

		Map<String, Double> event = new HashMap<>();
		event.put("x", x);
		event.put("y", y);
		event.put("z", z);
		this.eventSink.success(event);
	}

	@Override
	public void onError(String code, String message) {

		Log.i(TAG, String.format(
			"Error while streaming rotation vector: code %s, message %s", code, message));
		this.eventSink.error(code, message, "teste");
		if ("404".equals(code))
			this.eventSink.endOfStream();
	}
}
