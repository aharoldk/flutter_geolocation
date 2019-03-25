package com.aharoldk.piknik_background_geolocation;

import android.app.ActivityManager;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.os.Bundle;
import android.util.Log;

import androidx.localbroadcastmanager.content.LocalBroadcastManager;
import io.flutter.app.FlutterActivity;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity {
    private static final String CHANNEL = "com.piknik.asyik/enable_geolocation";
    private Class<?> serviceClass = GeolocationTrackingService.class;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        GeneratedPluginRegistrant.registerWith(this);

        new MethodChannel(getFlutterView(), CHANNEL).setMethodCallHandler(
                (call, result) -> {
                    Intent geolocationTrackingServiceIntent = new Intent(this.getApplicationContext(), serviceClass);
                    switch (call.method) {
                        case "startService":
                            startService(geolocationTrackingServiceIntent);
                            break;
                        case "stopService":
                            stopService(geolocationTrackingServiceIntent);
                            break;
                        case "isGeolocationTrackingService":
                            isGeolocationTrackingService();
                            break;
                    }
                });
    }

    private boolean isGeolocationTrackingService() {
        boolean isGeolocationTrackingService = false;

        ActivityManager manager = (ActivityManager) getSystemService(Context.ACTIVITY_SERVICE);
        for (ActivityManager.RunningServiceInfo service : manager.getRunningServices(Integer.MAX_VALUE)) {
            if (serviceClass.getName().equals(service.service.getClassName())) {
                Log.i("Service status", "Running");
                isGeolocationTrackingService = true;
            }
        }

        Log.i("Service status", "Not running");
        return isGeolocationTrackingService;
    }

    @Override
    protected void onDestroy() {
        super.onDestroy();

        if (isGeolocationTrackingService()) {
//            Intent broadcastIntent = new Intent();
//            broadcastIntent.setAction("com.aharoldk.piknik_background_geolocation.GeoLocationTracking");
//            broadcastIntent.setClass(this, GeolocationBroadcastReceiver.class);
//
//            this.sendBroadcast(broadcastIntent);

            LocalBroadcastManager localBroadcastManager = LocalBroadcastManager.getInstance(this);
            IntentFilter intentFilter =  new IntentFilter();
            intentFilter.addAction("com.aharoldk.piknik_background_geolocation.GeoLocationTracking");

            localBroadcastManager.registerReceiver(new GeolocationBroadcastReceiver(), intentFilter);

            Intent broadcastIntent = new Intent();
            broadcastIntent.setAction("com.aharoldk.piknik_background_geolocation.GeoLocationTracking");

            localBroadcastManager.sendBroadcast(broadcastIntent);

        }

    }
}
