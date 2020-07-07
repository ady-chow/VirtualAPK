/*
 * Copyright (C) 2017 Beijing Didi Infinity Technology and Development Co.,Ltd. All rights reserved.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package com.didi.virtualapk.internal;

import android.annotation.TargetApi;
import android.app.Activity;
import android.app.Application;
import android.app.Fragment;
import android.app.Instrumentation;
import android.content.ActivityNotFoundException;
import android.content.ComponentName;
import android.content.Context;
import android.content.Intent;
import android.content.pm.ActivityInfo;
import android.content.pm.ApplicationInfo;
import android.content.res.Configuration;
import android.os.Build;
import android.os.Bundle;
import android.os.Handler;
import android.os.IBinder;
import android.os.Message;
import android.os.PersistableBundle;
import android.util.Log;

import com.didi.virtualapk.PluginManager;
import com.didi.virtualapk.delegate.StubActivity;
import com.didi.virtualapk.internal.utils.PluginUtil;
import com.didi.virtualapk.utils.Reflector;

import java.lang.ref.WeakReference;
import java.lang.reflect.Field;
import java.util.ArrayList;
import java.util.List;


/**
 * Created by renyugang on 16/8/10.
 */
public class VAInstrumentation extends Instrumentation implements Handler.Callback {
    public static final String TAG = Constants.TAG_PREFIX + "VAInstrumentation";
    public static final int LAUNCH_ACTIVITY         = 100;
    public static final int EXECUTE_TRANSACTION     = 159;

    protected Instrumentation mBase;
    
    protected final ArrayList<WeakReference<Activity>> mActivities = new ArrayList<>();

    protected PluginManager mPluginManager;

    public VAInstrumentation(PluginManager pluginManager, Instrumentation base) {
        this.mPluginManager = pluginManager;
        this.mBase = base;
    }

    @Override
    public ActivityResult execStartActivity(Context who, IBinder contextThread, IBinder token, Activity target, Intent intent, int requestCode) {
        injectIntent(intent);
        return mBase.execStartActivity(who, contextThread, token, target, intent, requestCode);
    }

    @Override
    public ActivityResult execStartActivity(Context who, IBinder contextThread, IBinder token, Activity target, Intent intent, int requestCode, Bundle options) {
        injectIntent(intent);
        return mBase.execStartActivity(who, contextThread, token, target, intent, requestCode, options);
    }

    @Override
    public ActivityResult execStartActivity(Context who, IBinder contextThread, IBinder token, Fragment target, Intent intent, int requestCode, Bundle options) {
        injectIntent(intent);
        return mBase.execStartActivity(who, contextThread, token, target, intent, requestCode, options);
    }

    @Override
    public ActivityResult execStartActivity(Context who, IBinder contextThread, IBinder token, String target, Intent intent, int requestCode, Bundle options) {
        injectIntent(intent);
        return mBase.execStartActivity(who, contextThread, token, target, intent, requestCode, options);
    }
    
    protected void injectIntent(Intent intent) {
        Log.d("ady", "injectIntent: ");
        mPluginManager.getComponentsHandler().transformIntentToExplicitAsNeeded(intent);
        // null component is an implicitly intent
        if (intent.getComponent() != null) {
            Log.i(TAG, String.format("execStartActivity[%s : %s]", intent.getComponent().getPackageName(), intent.getComponent().getClassName()));
            // resolve intent with Stub Activity if needed
            this.mPluginManager.getComponentsHandler().markIntentIfNeeded(intent);
        }
    }

    @Override
    public Activity newActivity(ClassLoader cl, String className, Intent intent) throws InstantiationException, IllegalAccessException, ClassNotFoundException {
        Log.d("ady", "newActivity: ");
        try {
            cl.loadClass(className);
            Log.i(TAG, String.format("newActivity[%s]", className));
            
        } catch (ClassNotFoundException e) {
            ComponentName component = PluginUtil.getComponent(intent);
            
            if (component == null) {
                return newActivity(mBase.newActivity(cl, className, intent));
            }
    
            String targetClassName = component.getClassName();
            Log.i(TAG, String.format("newActivity[%s : %s/%s]", className, component.getPackageName(), targetClassName));
    
            LoadedPlugin plugin = this.mPluginManager.getLoadedPlugin(component);
    
            if (plugin == null) {
                // Not found then goto stub activity.
                boolean debuggable = false;
                try {
                    Context context = this.mPluginManager.getHostContext();
                    debuggable = (context.getApplicationInfo().flags & ApplicationInfo.FLAG_DEBUGGABLE) != 0;
                } catch (Throwable ex) {
        
                }
    
                if (debuggable) {
                    throw new ActivityNotFoundException("error intent: " + intent.toURI());
                }
                
                Log.i(TAG, "Not found. starting the stub activity: " + StubActivity.class);
                return newActivity(mBase.newActivity(cl, StubActivity.class.getName(), intent));
            }

            Log.d("ady", "newActivity: intent = " + intent);

            Activity activity = mBase.newActivity(plugin.getClassLoader(), targetClassName, intent);
            activity.setIntent(intent);

            Log.d("ady", "newActivity: activity = " + activity);

            // for 4.1+
            Reflector.QuietReflector.with(activity).field("mResources").set(plugin.getResources());

//            int targetTheme = intent.getIntExtra(Constants.EXTRA_THEME, 0x1);
//
//            Log.d("ady", "newActivity: target theme = 0x" + Integer.toHexString(targetTheme));
//            if(activity instanceof AppCompatActivity){
//                try {
//                    if (!fieldsPrinted) {
//                        fieldsPrinted = true;
//                        Field[] fields = AppCompatActivity.class.getDeclaredFields();
//                        for(Field f:fields){
//                            Log.d("ady", "newActivity: f = " + f.getName());
//                        }
//                    }
//                    Field field = AppCompatActivity.class.getDeclaredField("mThemeId");
//                    field.setAccessible(true);
//                    Log.d("ady", "newActivity: origin theme = 0x" + Integer.toHexString((int) field.get(activity)));
//                    field.set(activity, targetTheme);
//                } catch (Exception ex) {
//                    Log.e("ady", "newActivity: ", ex);
//                }
//            }

//            if(activity instanceof AppCompatActivity) {
//                AppCompatDelegate delegate = Reflector.QuietReflector.with(activity)
//                    .method("getDelegate").call();
//                Log.d("ady", "newActivity: delegate = " + delegate);
//                delegate.setTheme(targetTheme);
//            }

            Log.d("ady", "newActivity: activity = " + activity);

            return newActivity(activity);
        }

        return newActivity(mBase.newActivity(cl, className, intent));
    }
    
    @Override
    public Application newApplication(ClassLoader cl, String className, Context context) throws InstantiationException, IllegalAccessException, ClassNotFoundException {
        Log.d("ady", "newApplication: ");
        return mBase.newApplication(cl, className, context);
    }

    @Override
    public void callActivityOnCreate(Activity activity, Bundle icicle) {
        injectActivity(activity);
        mBase.callActivityOnCreate(activity, icicle);
    }
    
    @TargetApi(Build.VERSION_CODES.LOLLIPOP)
    @Override
    public void callActivityOnCreate(Activity activity, Bundle icicle, PersistableBundle persistentState) {
        injectActivity(activity);
        mBase.callActivityOnCreate(activity, icicle, persistentState);
    }
    
    protected void injectActivity(Activity activity) {
        Log.d("ady", "injectActivity: " + activity);
        final Intent intent = activity.getIntent();
        if (PluginUtil.isIntentFromPlugin(intent)) {
            Context base = activity.getBaseContext();
            try {
                LoadedPlugin plugin = this.mPluginManager.getLoadedPlugin(intent);
                Reflector.with(base).field("mResources").set(plugin.getResources());
                Reflector reflector = Reflector.with(activity);
                reflector.field("mBase").set(plugin.createPluginContext(activity.getBaseContext()));
                reflector.field("mApplication").set(plugin.getApplication());

                // set screenOrientation
                ActivityInfo activityInfo = plugin.getActivityInfo(PluginUtil.getComponent(intent));
                if (activityInfo.screenOrientation != ActivityInfo.SCREEN_ORIENTATION_UNSPECIFIED) {
                    activity.setRequestedOrientation(activityInfo.screenOrientation);
                }

                Log.d("ady", "injectActivity: activityInfo.configChanges = " + activityInfo.configChanges);
                Configuration configuration = new Configuration();
                configuration.keyboard = activityInfo.configChanges & ActivityInfo.CONFIG_KEYBOARD;
                configuration.keyboardHidden = activityInfo.configChanges & ActivityInfo.CONFIG_KEYBOARD_HIDDEN;
                configuration.orientation = activityInfo.configChanges & ActivityInfo.CONFIG_ORIENTATION;
                configuration.screenLayout = activityInfo.configChanges & ActivityInfo.CONFIG_SCREEN_LAYOUT;
                Log.d("ady", "injectActivity: configuration.keyboard = " + configuration.keyboard);
                Log.d("ady", "injectActivity: configuration.keyboardHidden = " + configuration.keyboardHidden);
                Log.d("ady", "injectActivity: configuration.orientation = " + configuration.orientation);
                Log.d("ady", "injectActivity: configuration.screenLayout = " + configuration.screenLayout);


                // for native activity
                ComponentName component = PluginUtil.getComponent(intent);
                Intent wrapperIntent = new Intent(intent);
                wrapperIntent.setClassName(component.getPackageName(), component.getClassName());
                wrapperIntent.setExtrasClassLoader(activity.getClassLoader());
                activity.setIntent(wrapperIntent);
                activity.setTheme(activityInfo.theme);
            } catch (Exception e) {
                Log.w(TAG, e);
            }
        }
    }

    @Override
    public boolean handleMessage(Message msg) {
        Log.d("ady", "handleMessage: msg.what = " + msg.what);
        if (msg.what == LAUNCH_ACTIVITY) {
            // ActivityClientRecord r
            Object r = msg.obj;
            try {
                Reflector reflector = Reflector.with(r);
                Intent intent = reflector.field("intent").get();
//                intent.setExtrasClassLoader(mPluginManager.getHostContext().getClassLoader());
                ActivityInfo activityInfo = reflector.field("activityInfo").get();

                if (PluginUtil.isIntentFromPlugin(intent)) {
                    Log.d("ady", "handleMessage: intent from plugin");
                    ComponentName componentName = PluginUtil.getComponent(intent);
                    int theme = PluginUtil.getTheme(mPluginManager.getHostContext(), componentName);
                    if (theme != 0) {
                        Log.i(TAG, "resolve theme, current theme:" + activityInfo.theme + "  after :0x" + Integer.toHexString(theme));
                        activityInfo.theme = theme;
                    }
                    activityInfo.configChanges = PluginUtil.getConfigChanges(mPluginManager.getHostContext(), componentName);
                    activityInfo.softInputMode = PluginUtil.getSoftInputMode(mPluginManager.getHostContext(), componentName);
                } else {
                    Log.d("ady", "handleMessage: intent not from plugin!");
                }
            } catch (Exception e) {
                Log.w("ady", e);
            }
        } else if(msg.what == EXECUTE_TRANSACTION) {
            // ClientTransaction r
            Object r = msg.obj;
            try {
                Class clientClazz = r.getClass();
                Field fCallbacks = clientClazz.getDeclaredField("mActivityCallbacks");
                fCallbacks.setAccessible(true);
                //得到transaction中的callbacks,为一个list,其中元素为LaunchActivityItem
                List<?> lists = (List) fCallbacks.get(r);
                for(int i=0;i<lists.size();i++){
                    Object item = lists.get(i);
                    Class itemClazz = item.getClass();
                    //拿到LaunchActivityItem中的intent，进行替换
                    Field mIntent = itemClazz.getDeclaredField("mIntent");
                    mIntent.setAccessible(true);
                    Intent intent = (Intent) mIntent.get(item);
                    if (PluginUtil.isIntentFromPlugin(intent)) {
                        Log.d("ady", "handleMessage: intent from plugin");
                        ComponentName componentName = PluginUtil.getComponent(intent);
                        intent.setComponent(componentName);
                        Field mInfo = itemClazz.getDeclaredField("mInfo");
                        mInfo.setAccessible(true);
                        ActivityInfo activityInfo = (ActivityInfo) mInfo.get(item);
                        Log.d("ady", "handleMessage: activityInfo  = " + activityInfo);
                        if (activityInfo != null) {
                            int theme = PluginUtil.getTheme(mPluginManager.getHostContext(), componentName);
                            if (theme != 0) {
                                Log.i(TAG, "resolve theme, current theme:" + activityInfo.theme + "  after :0x" + Integer.toHexString(theme));
                                activityInfo.theme = theme;
                            }
                            activityInfo.configChanges = PluginUtil.getConfigChanges(mPluginManager.getHostContext(), componentName);
                            activityInfo.softInputMode = PluginUtil.getSoftInputMode(mPluginManager.getHostContext(), componentName);
                        }
                    } else {
                        Log.d("ady", "handleMessage: intent not from plugin !");
                    }
                }
            } catch (Exception e) {
                Log.e("ady", "handleMessage: ", e);
            }
        }
        return false;
    }

    @Override
    public Context getContext() {
        return mBase.getContext();
    }

    @Override
    public Context getTargetContext() {
        return mBase.getTargetContext();
    }

    @Override
    public ComponentName getComponentName() {
        return mBase.getComponentName();
    }

    protected Activity newActivity(Activity activity) {
        synchronized (mActivities) {
            for (int i = mActivities.size() - 1; i >= 0; i--) {
                if (mActivities.get(i).get() == null) {
                    mActivities.remove(i);
                }
            }
            mActivities.add(new WeakReference<>(activity));
        }
        return activity;
    }

    List<WeakReference<Activity>> getActivities() {
        synchronized (mActivities) {
            return new ArrayList<>(mActivities);
        }
    }
}
