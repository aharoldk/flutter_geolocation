package com.aharoldk.piknik_background_geolocation;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.os.Build;
import android.util.Log;

public class GeolocationBroadcastReceiver extends BroadcastReceiver {
    @Override
    public void onReceive(Context context, Intent intent) {
        Log.d("GeoLocationTracking", "onReceive: ");

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            context.startForegroundService(new Intent(context, GeolocationTrackingService.class));
        } else {
            context.startService(new Intent(context, GeolocationTrackingService.class));
        }
    }
}
