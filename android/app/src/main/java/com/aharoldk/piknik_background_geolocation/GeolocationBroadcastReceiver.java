package com.aharoldk.piknik_background_geolocation;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.util.Log;

public class GeolocationBroadcastReceiver extends BroadcastReceiver {
    @Override
    public void onReceive(Context context, Intent intent) {
        Log.d("GeolocationBroadcast", "onReceive: ");
        context.startService(new Intent(context, GeolocationTrackingService.class));
    }
}
