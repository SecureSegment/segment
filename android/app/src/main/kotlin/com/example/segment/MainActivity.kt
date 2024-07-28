package com.example.segment

import android.content.Intent
import android.net.VpnService
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {
    private val CHANNEL = "com.example.segment/xray"
    private val VPN_REQUEST_CODE = 1

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            when (call.method) {
                "startVpn" -> {
                    val vpnIntent = VpnService.prepare(this)
                    if (vpnIntent != null) {
                        println("VPN preparation required")
                        startActivityForResult(vpnIntent, VPN_REQUEST_CODE)
                         result.success("VPN permission requested")
                    } else {
                        println("VPN already prepared")
                        onActivityResult(VPN_REQUEST_CODE, RESULT_OK, null)
                        result.success("VPN permission already granted")
                    }
}
                "stopVpn" -> {
                    val serviceIntent = Intent(this, XrayVpnService::class.java)
                    serviceIntent.action = "STOP"
                    startService(serviceIntent)
                    result.success("Stop VPN service requested")
                }
                "isVpnRunning" -> {
                    val isRunning = XrayVpnService.isRunning
                    result.success(isRunning)
                }
                else -> result.notImplemented()
            }
        }
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)
        if (requestCode == VPN_REQUEST_CODE && resultCode == RESULT_OK) {
            val serviceIntent = Intent(this, XrayVpnService::class.java)
            serviceIntent.action = "START"
            startService(serviceIntent)
        } else if (requestCode == VPN_REQUEST_CODE) {
            
            println("VPN permission denied")
        }
    }
}