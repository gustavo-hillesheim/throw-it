package com.hill.throw_it;

import android.os.Bundle;

import com.hill.throw_it.rotation_vector.RotationVectorChannel;

import io.flutter.app.FlutterActivity;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity {
  @Override
  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    GeneratedPluginRegistrant.registerWith(this);
    RotationVectorChannel.init(this);
  }
}
