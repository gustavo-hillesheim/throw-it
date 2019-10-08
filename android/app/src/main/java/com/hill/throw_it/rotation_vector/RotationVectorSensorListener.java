package com.hill.throw_it.rotation_vector;

import android.app.Activity;
import android.hardware.Sensor;
import android.hardware.SensorEvent;
import android.hardware.SensorEventListener;
import android.hardware.SensorManager;
import android.view.Surface;
import android.view.WindowManager;

import java.util.ArrayList;
import java.util.List;

import io.flutter.Log;

public class RotationVectorSensorListener implements SensorEventListener {

	private final String TAG = "RotationSensorListener";
	private final int SENSOR_DELAY_MICROS = 16 * 1000;
	private final WindowManager windowManager;
	private final SensorManager sensorManager;
	private final Sensor rotationSensor;
	private boolean hasRotationSensor;
	private int lastAccuracy;
	private List<RotationVectorListener> listeners;


	public RotationVectorSensorListener(Activity activity) {

		listeners = new ArrayList<>();
		windowManager = activity.getWindow().getWindowManager();
		sensorManager = (SensorManager) activity.getSystemService(Activity.SENSOR_SERVICE);

		if (sensorManager != null) {
			rotationSensor = sensorManager.getDefaultSensor(Sensor.TYPE_ROTATION_VECTOR);
			hasRotationSensor = sensorManager.registerListener(this, rotationSensor, SENSOR_DELAY_MICROS);
		} else {
			rotationSensor = null;
		}
	}

	public void registerListener(RotationVectorListener listener) {

		if (!hasRotationSensor || rotationSensor == null) {
			listener.onError("404", "Rotation sensor not available.");
		} else {
			listeners.add(listener);
		}
	}

	public void unregisterListener(RotationVectorListener listener) {
		listeners.remove(listener);
	}

	public void stopListening() {

		sensorManager.unregisterListener(this);
		listeners.clear();
	}

	@Override
	public void onAccuracyChanged(Sensor sensor, int accuracy) {

		if (lastAccuracy != accuracy) {
			lastAccuracy = accuracy;
		}
	}

	@Override
	public void onSensorChanged(SensorEvent event) {

		if (listeners == null || listeners.isEmpty())
			return;

		if (lastAccuracy == SensorManager.SENSOR_STATUS_UNRELIABLE)
			return;

		if (event.sensor == rotationSensor)
			updateOrientation(event.values);
	}

	private void updateOrientation(float[] rotationVector) {

		float[] rotationMatrix = new float[9];
		float[] rotation = new float[3];

		SensorManager.getRotationMatrixFromVector(rotationMatrix, rotationVector);

		final int worldAxisForDeviceAxisX;
		final int worldAxisForDeviceAxisY;

		switch (windowManager.getDefaultDisplay().getRotation()) {
			case Surface.ROTATION_0:
			default:
				worldAxisForDeviceAxisX = SensorManager.AXIS_X;
				worldAxisForDeviceAxisY = SensorManager.AXIS_Z;
				break;
			case Surface.ROTATION_90:
				worldAxisForDeviceAxisX = SensorManager.AXIS_Z;
				worldAxisForDeviceAxisY = SensorManager.AXIS_MINUS_X;
				break;
			case Surface.ROTATION_180:
				worldAxisForDeviceAxisX = SensorManager.AXIS_MINUS_X;
				worldAxisForDeviceAxisY = SensorManager.AXIS_MINUS_Z;
				break;
			case Surface.ROTATION_270:
				worldAxisForDeviceAxisX = SensorManager.AXIS_MINUS_Z;
				worldAxisForDeviceAxisY = SensorManager.AXIS_X;
				break;
		}

		float[] adjustedRotationMatrix = new float[9];
		SensorManager.remapCoordinateSystem(rotation, worldAxisForDeviceAxisX,
			worldAxisForDeviceAxisY, adjustedRotationMatrix);

		SensorManager.getOrientation(rotationMatrix, rotation);

		double z = rotation[0];
		double x = rotation[1];
		double y = rotation[2];

		for (RotationVectorListener listener : listeners) {
			listener.onChange(x, y, z);
		}
	}
}
