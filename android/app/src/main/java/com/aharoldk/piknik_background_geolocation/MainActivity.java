package com.aharoldk.piknik_background_geolocation;

import android.content.Intent;
import android.os.Bundle;
import android.util.Log;

import io.flutter.app.FlutterActivity;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity {
  private static final String CHANNEL = "com.piknik.asyik/enable_geolocation";
  @Override
  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    GeneratedPluginRegistrant.registerWith(this);

    new MethodChannel(getFlutterView(), CHANNEL).setMethodCallHandler(
            (call, result) -> {
              Intent geolocationTrackingServiceIntent = new Intent(this.getApplicationContext(), GeolocationTrackingService.class);
              switch (call.method) {
                case "startService":
                  startService(geolocationTrackingServiceIntent);
                  break;
                case "stopService":
                  stopService(geolocationTrackingServiceIntent);
                  break;
              }
            });
  }
}
