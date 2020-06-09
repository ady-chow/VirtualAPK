package com.didi.virtualapk;

import android.Manifest.permission;
import android.app.Activity;
import android.content.pm.PackageManager;
import android.os.Bundle;
import android.util.Log;
import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

/** Created by zhouxinyuan on 2020-06-08. */
public class PermissionActivity extends Activity {

  private static final int PERMISSION_REQUEST_CODE_LOCATION = 20171222;

  @Override
  protected void onCreate(@Nullable Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    Log.d("ady", "onCreate: PermissionActivity");
    requestPermissions(
        new String[] {permission.ACCESS_FINE_LOCATION}, PERMISSION_REQUEST_CODE_LOCATION);
  }

  @Override
  public void onRequestPermissionsResult(
      int requestCode, @NonNull String[] permissions, @NonNull int[] grantResults) {
    Log.d("ady", "onRequestPermissionsResult: " + this);
    for (int i = 0; i < permissions.length; i++) {
      Log.d(
          "ady",
          "onRequestPermissionsResult: "
              + permissions[i]
              + ", "
              + (grantResults[i] == PackageManager.PERMISSION_GRANTED));
    }
    setResult(RESULT_OK);
    finish();
  }
}
