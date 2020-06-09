package com.didi.virtualapk.demo;

import android.app.Application;
import android.content.Context;
import android.os.Process;
import android.util.Log;
import com.didi.virtualapk.internal.PluginContext;
import com.didi.virtualapk.utils.MyUtils;

public class MyApplication extends Application {

  private static final String TAG = "MyApplication";

  public static Context mHostContext;

  @Override
  protected void attachBaseContext(Context base) {
    super.attachBaseContext(base);
    mHostContext = ((PluginContext) base).getHostContext();
  }

  @Override
  public void onCreate() {
    super.onCreate();
    String processName = MyUtils.getProcessName(getApplicationContext(), Process.myPid());
    Log.d(TAG, "application start, process name:" + processName);
    new Thread(
            new Runnable() {

              @Override
              public void run() {
                doWorkInBackground();
              }
            })
        .start();
  }

  private void doWorkInBackground() {
    // init binder pool
    // BinderPool.getInsance(getApplicationContext());
  }
}
