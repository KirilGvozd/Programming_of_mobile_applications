package com.example.lab4_5

import android.os.BatteryManager
import android.content.Context
import android.os.Bundle
import android.telephony.SmsManager
import io.flutter.embedding.android.FlutterActivity
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugins.GeneratedPluginRegistrant

class MainActivity : FlutterActivity() {
    private val channelName = "sendSms"
    private val batteryChannelName = "battery"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        GeneratedPluginRegistrant.registerWith(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, channelName).setMethodCallHandler(
            object : MethodChannel.MethodCallHandler {
                override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
                    when (call.method) {
                        "send" -> {
                            val num: String? = call.argument("phone")
                            val msg: String? = call.argument("msg")
                            if (num != null && msg != null) {
                                sendSMS(num, msg, result)
                            } else {
                                result.error("InvalidArguments", "Phone number or message is null", null)
                            }
                        }
                        else -> {
                            result.notImplemented()
                        }
                    }
                }
            }
        )

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, batteryChannelName).setMethodCallHandler(
            object : MethodChannel.MethodCallHandler {
                override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
                    when (call.method) {
                        "getBatteryLevel" -> {
                            val batteryLevel = getBatteryLevel()
                            if (batteryLevel != -1) {
                                result.success(batteryLevel)
                            } else {
                                result.error("UNAVAILABLE", "Battery level not available.", null)
                            }
                        }
                        else -> {
                            result.notImplemented()
                        }
                    }
                }
            }
        )
    }

    private fun sendSMS(phoneNo: String, msg: String, result: MethodChannel.Result) {
        try {
            val smsManager: SmsManager = SmsManager.getDefault()
            smsManager.sendTextMessage(phoneNo, null, msg, null, null)
            result.success("SMS Sent")
        } catch (ex: Exception) {
            ex.printStackTrace()
            result.error("Err", "Sms Not Sent", "")
        }
    }

    private fun getBatteryLevel(): Int {
        val batteryManager = getSystemService(Context.BATTERY_SERVICE) as BatteryManager
        return batteryManager.getIntProperty(BatteryManager.BATTERY_PROPERTY_CAPACITY)
    }
}
