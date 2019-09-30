package com.hill.throw_it.rotation_vector;

public interface RotationVectorListener {

	void onChange(double x, double y, double z);
	void onError(String errorCode, String errorMessage);
}
