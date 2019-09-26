package com.hill.throw_it.rotation_vector;

import android.hardware.Sensor;
import android.hardware.SensorEvent;
import android.hardware.SensorEventListener;

import java.util.ArrayList;
import java.util.List;

public class RotationVectorSensorListener implements SensorEventListener {


	private static List<RotationVectorListener> listeners = new ArrayList<>();

	@Override
	public void onSensorChanged(SensorEvent event) {

	}

	@Override
	public void onAccuracyChanged(Sensor sensor, int accuracy) {

	}

	public static void registerListener(RotationVectorListener listener) {
		listeners.add(listener);
	}

	public static void unregisterListener(RotationVectorListener listener) {
		listeners.remove(listener);
	}
}
