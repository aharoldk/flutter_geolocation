package com.aharoldk.piknik_background_geolocation;

import android.Manifest;
import android.app.Service;
import android.content.Context;
import android.content.Intent;
import android.content.pm.PackageManager;
import android.location.Location;
import android.location.LocationListener;
import android.location.LocationManager;
import android.os.Bundle;
import android.os.IBinder;
import android.support.v4.app.ActivityCompat;
import android.util.Log;
import android.widget.Toast;

public class GeolocationTrackingService extends Service {
    private LocationManager locationManager;
    private LocationListener locationListener;

    @Override
    public int onStartCommand(Intent intent, int flags, int startId) {
        locationManager = (LocationManager) getApplicationContext().getSystemService(Context.LOCATION_SERVICE);

        boolean isGranted = ActivityCompat.checkSelfPermission(this, Manifest.permission.ACCESS_FINE_LOCATION) == PackageManager.PERMISSION_GRANTED || ActivityCompat.checkSelfPermission(this, Manifest.permission.ACCESS_COARSE_LOCATION) == PackageManager.PERMISSION_GRANTED;

        locationListener = new LocationListener() {
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
        };


        if (isGranted) {
            locationManager.requestLocationUpdates(LocationManager.NETWORK_PROVIDER, 5000, 0, locationListener);
        }

        return Service.START_STICKY;
    }

    @Override
    public void onDestroy() {
//        locationManager.removeUpdates(locationListener);
//        locationManager = null;
//        Log.d("GeoLocationTracking", "location manager: "+locationManager);
        Log.d("GeoLocationTracking", "onDestroy Service");
        super.onDestroy();
    }

    @Override
    public IBinder onBind(Intent intent) {
        return null;
    }
}
