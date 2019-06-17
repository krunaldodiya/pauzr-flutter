package com.pauzr.org;

import android.os.Bundle;
import io.flutter.app.FlutterActivity;
import io.flutter.plugin.common.StringCodec;
import io.flutter.plugins.GeneratedPluginRegistrant;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;

import android.content.Context;
import android.app.KeyguardManager;
// import android.view.WindowManager.LayoutParams;

public class MainActivity extends FlutterActivity {
  private static final String CHANNEL = "com.pauzr.org/info";

  @Override
  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    GeneratedPluginRegistrant.registerWith(this);
    // getWindow().addFlags(LayoutParams.FLAG_SECURE);

    new MethodChannel(getFlutterView(), CHANNEL).setMethodCallHandler(new MethodCallHandler() {
      @Override
      public void onMethodCall(MethodCall call, MethodChannel.Result result) {
        if (call.method.equals("getDeviceStatus")) {
          KeyguardManager keyGuardManager = (KeyguardManager) getSystemService(Context.KEYGUARD_SERVICE);
          result.success(keyGuardManager.inKeyguardRestrictedInputMode());
        }
      }
    });
  }
}
