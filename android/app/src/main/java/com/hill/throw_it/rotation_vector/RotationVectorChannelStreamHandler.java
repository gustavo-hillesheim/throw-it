package com.hill.throw_it.rotation_vector;

import android.app.Activity;

import java.util.HashMap;
import java.util.Map;

import io.flutter.Log;
import io.flutter.plugin.common.EventChannel;


class RotationVectorChannelStreamHandler implements EventChannel.StreamHandler {

	private final String TAG = "RotationVectorStream";
	private RotationVectorSensorListener sensorListener;
	private Map<Object, RotationVectorListener> listeners = new HashMap<>();

	RotationVectorChannelStreamHandler(Activity activity) {
		this.sensorListener = new RotationVectorSensorListener(activity);
	}

	@Override
	public void onListen(Object o, EventChannel.EventSink eventSink) {

		if (listeners.get(o) == null) {
			listeners.put(o,
				new RotationVectorStreamer(eventSink));
		}

		Log.i(TAG, String.format(
			"Registering rotation vector listener %d",
			listeners.get(o).hashCode()));
		sensorListener.registerListener(listeners.get(o));
	}

	@Override
	public void onCancel(Object o) {

		Log.i(TAG, String.format(
			"Unregistering rotation vector listener %d",
			listeners.get(o).hashCode()));
		RotationVectorListener listener = listeners.get(o);
		if (listener != null) {
			sensorListener.unregisterListener(listener);
			listeners.remove(o);
		}
	}
}
