package com.hill.throw_it.rotation_vector;

import io.flutter.Log;
import io.flutter.app.FlutterActivity;
import io.flutter.plugin.common.EventChannel;

public class RotationVectorChannel extends FlutterActivity {


	private final String STREAM_CHANNEL_NAME = "io.hill.rotation-vector/stream";
	private final String TAG = "RotationVectorChannel";
	private boolean started;

	public void init() {

		if (!started) {

			new EventChannel(getFlutterView(), STREAM_CHANNEL_NAME)
				.setStreamHandler(new RotationVectorChannelStreamHandler(TAG));
		} else {
			Log.i(TAG, "Cannot init RotationVectorChannel since it's already initiated");
		}
	}
}
