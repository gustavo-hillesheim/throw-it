package com.hill.throw_it.rotation_vector;

import io.flutter.Log;
import io.flutter.app.FlutterActivity;
import io.flutter.plugin.common.EventChannel;

public class RotationVectorChannel {


	private static final String STREAM_CHANNEL_NAME = "io.hill.rotation_vector/stream";
	private static final String TAG = "RotationVectorChannel";
	private static boolean started;

	public static void init(FlutterActivity activity) {

		if (!started) {

			new EventChannel(activity.getFlutterView(), STREAM_CHANNEL_NAME)
				.setStreamHandler(new RotationVectorChannelStreamHandler(TAG, activity));
			started = true;
		} else {
			Log.i(TAG, "Cannot init RotationVectorChannel since it's already initiated");
		}
	}
}
