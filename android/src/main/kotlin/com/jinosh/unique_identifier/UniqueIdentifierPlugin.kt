package com.jinosh.unique_identifier

import android.content.Context
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import android.provider.Settings.Secure

class UniqueIdentifierPlugin : FlutterPlugin, MethodCallHandler {
   private lateinit var channel: MethodChannel
   private lateinit var context: Context

   override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
       channel = MethodChannel(flutterPluginBinding.binaryMessenger, "unique_identifier")
       context = flutterPluginBinding.applicationContext
       channel.setMethodCallHandler(this)
   }

   override fun onMethodCall(call: MethodCall,  result: Result) {
       if (call.method == "getUniqueIdentifier") {
           val androidId = if (android.os.Build.VERSION.SDK_INT >= android.os.Build.VERSION_CODES.CUPCAKE) {
               Secure.getString(context.contentResolver, Secure.ANDROID_ID)
           } else {
               null
           }
           result.success(androidId)
       } else {
           result.notImplemented()
       }
   }

   override fun onDetachedFromEngine( binding: FlutterPlugin.FlutterPluginBinding) {
       channel.setMethodCallHandler(null)
   }
}