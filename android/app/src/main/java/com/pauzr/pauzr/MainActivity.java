package com.pauzr.org;

import android.os.Bundle;

import io.flutter.app.FlutterActivity;
import io.flutter.plugins.GeneratedPluginRegistrant;

import io.flutter.plugin.common.EventChannel;
import io.flutter.plugin.common.EventChannel.EventSink;
import io.flutter.plugin.common.EventChannel.StreamHandler;

// import io.flutter.plugin.common.MethodCall;
// import io.flutter.plugin.common.MethodChannel;
// import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
// import io.flutter.plugin.common.MethodChannel.Result;

import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.content.BroadcastReceiver;
import android.util.Log;

import android.view.WindowManager.LayoutParams;

public class MainActivity extends FlutterActivity {
  private static final String CHANNEL = "com.pauzr.org/info";

  @Override
  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    GeneratedPluginRegistrant.registerWith(this);

    getWindow().addFlags(LayoutParams.FLAG_SECURE);

    new EventChannel(getFlutterView(), CHANNEL).setStreamHandler(new EventChannel.StreamHandler() {
      private BroadcastReceiver screenStateChangeReceiver;

      @Override
      public void onListen(Object args, final EventChannel.EventSink events) {
        IntentFilter filter = new IntentFilter(Intent.ACTION_SCREEN_ON);
        filter.addAction(Intent.ACTION_SCREEN_OFF);
        filter.addAction(Intent.ACTION_USER_PRESENT);

        screenStateChangeReceiver = createScreenStateChangeReceiver(events);
        registerReceiver(screenStateChangeReceiver, filter);
      }

      @Override
      public void onCancel(Object arguments) {
        unregisterReceiver(screenStateChangeReceiver);
        screenStateChangeReceiver = null;
      }
    });

    // new MethodChannel(getFlutterView(), CHANNEL).setMethodCallHandler(new
    // MethodCallHandler() {
    // @Override
    // public void onMethodCall(MethodCall call, Result result) {
    // if (call.method.equals("getScreenStatus")) {
    // result.success("ACTION_SCREEN_OFF");
    // }
    // }
    // });
  }

  private BroadcastReceiver createScreenStateChangeReceiver(final EventSink events) {
    return new BroadcastReceiver() {
      @Override
      public void onReceive(Context context, Intent intent) {
        if (intent.getAction().equals(Intent.ACTION_SCREEN_OFF)) {
          events.success("ACTION_SCREEN_OFF");
        } else if (intent.getAction().equals(Intent.ACTION_SCREEN_ON)) {
          events.success("ACTION_SCREEN_ON");
        }
      }
    };
  }
}
