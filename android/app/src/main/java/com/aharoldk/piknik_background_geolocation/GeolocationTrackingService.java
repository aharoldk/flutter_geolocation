package com.aharoldk.piknik_background_geolocation;

import android.Manifest;
import android.app.Notification;
import android.app.NotificationChannel;
import android.app.NotificationManager;
import android.app.Service;
import android.content.Context;
import android.content.Intent;
import android.content.pm.PackageManager;
import android.graphics.Color;
import android.location.Location;
import android.location.LocationListener;
import android.location.LocationManager;
import android.os.Build;
import android.os.Bundle;
import android.os.IBinder;
import android.support.annotation.RequiresApi;
import android.support.v4.app.ActivityCompat;
import android.support.v4.app.NotificationCompat;
import android.util.Log;
import android.widget.Toast;

public class GeolocationTrackingService extends Service {
    private LocationManager locationManager;
    @Override
    public int onStartCommand(Intent intent, int flags, int startId) {
        Log.d("GeoLocationTracking", "Start Service");

        boolean isGranted = ActivityCompat.checkSelfPermission(this, Manifest.permission.ACCESS_FINE_LOCATION) == PackageManager.PERMISSION_GRANTED || ActivityCompat.checkSelfPermission(this, Manifest.permission.ACCESS_COARSE_LOCATION) == PackageManager.PERMISSION_GRANTED;

        if (isGranted) {
            Log.d("GeoLocationTracking", "isGranted");
            locationManager = (LocationManager) getApplicationContext().getSystemService(Context.LOCATION_SERVICE);
            locationManager.requestLocationUpdates(LocationManager.NETWORK_PROVIDER, 5000, 0, new LocationListener() {
                @Override
                public void onLocationChanged(Location location) {
                    double mLat = location.getLatitude();
                    double mLong = location.getLongitude();

                    Toast.makeText(getApplicationContext(), "onLocationChanged: latitude: "+ mLat + " ------ longitude: "+ mLong, Toast.LENGTH_LONG).show();
                    Log.d("GeoLocationTracking", "onLocationChanged: latitude: "+ mLat + " ------ longitude: "+ mLong);
                }

                @Override
                public void onStatusChanged(String provider, int status, Bundle extras) {

                }

                @Override
                public void onProviderEnabled(String provider) {

                }

                @Override
                public void onProviderDisabled(String provider) {

                }
            });
        }

        return Service.START_NOT_STICKY;
    }

    @Override
    public void onDestroy() {
        locationManager = null;
        Log.d("GeoLocationTracking", "onDestroy Service");
        super.onDestroy();
    }

    @Override
    public IBinder onBind(Intent intent) {
        return null;
    }
}
