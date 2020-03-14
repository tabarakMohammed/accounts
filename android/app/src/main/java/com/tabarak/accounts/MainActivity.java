package com.tabarak.accounts;

import android.os.Bundle;

import androidx.annotation.NonNull;


import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity   {

//    @Override
//    protected void onCreate(Bundle savedInstanceState) {
//        super.onCreate(savedInstanceState);
//        GeneratedPluginRegistrant.registerWith(this.getFlutterEngine());
//    }

    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        super.configureFlutterEngine(flutterEngine);
        GeneratedPluginRegistrant.registerWith(flutterEngine);

    }

}
