package com.hill.throw_it.rotation_vector;

import android.app.Activity;

import java.util.HashMap;
import java.util.Map;

import io.flutter.Log;
import io.flutter.plugin.common.EventChannel;


class RotationVectorChannelStreamHandler implements EventChannel.StreamHandler {

	private String tag;
	private RotationVectorSensorListener sensorListener;
	private Map<Object, RotationVectorListener> listeners = new HashMap<>();

	RotationVectorChannelStreamHandler(String tag, Activity activity) {
		this.tag = tag;
		this.sensorListener = new RotationVectorSensorListener(activity);
	}

	@Override
	public void onListen(Object o, EventChannel.EventSink eventSink) {

		if (listeners.get(o) == null) {
			listeners.put(o,
				new RotationVectorStreamer("RotationVectorStreamer", eventSink));
		}

		Log.i(tag, String.format(
			"Registering rotation vector listener %d",
			listeners.get(o).hashCode()));
		sensorListener.registerListener(listeners.get(o));
	}

	@Override
	public void onCancel(Object o) {

		Log.i(tag, String.format(
			"Unregistering rotation vector listener %d",
			listeners.get(o).hashCode()));
		RotationVectorListener listener = listeners.get(o);
		if (listener != null) {
			sensorListener.unregisterListener(listener);
			listeners.remove(o);
		}
	}
}
