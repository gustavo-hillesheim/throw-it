package com.hill.throw_it.rotation_vector;

import java.util.HashMap;
import java.util.Map;

import io.flutter.Log;
import io.flutter.plugin.common.EventChannel;


class RotationVectorChannelStreamHandler implements EventChannel.StreamHandler {

	private String tag;
	private Map<Object, RotationVectorListener> listeners = new HashMap<>();

	RotationVectorChannelStreamHandler(String tag) {

		this.tag = tag;
	}

	@Override
	public void onListen(Object o, EventChannel.EventSink eventSink) {

		if (listeners.get(o) == null)
			listeners.put(o, new RotationVectorStreamer(eventSink));

		Log.i(tag, "Adding listener");
		RotationVectorSensorListener
			.registerListener(listeners.get(o));
	}

	@Override
	public void onCancel(Object o) {

		Log.i(tag, "Cancelling listener");
		RotationVectorListener listener = listeners.get(o);
		if (listener != null) {
			RotationVectorSensorListener
				.unregisterListener(listener);
			listeners.remove(o);
		}
	}
}
