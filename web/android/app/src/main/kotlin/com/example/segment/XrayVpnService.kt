package com.example.segment

import android.annotation.TargetApi
import android.content.Intent
import android.net.VpnService
import android.os.Build
import android.os.ParcelFileDescriptor
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
import java.io.File

@TargetApi(Build.VERSION_CODES.ICE_CREAM_SANDWICH)
class XrayVpnService : VpnService() {
    private external fun startXray(configPath: String): Int
    private external fun stopXray(): Int

    private var vpnInterface: ParcelFileDescriptor? = null
    private val serviceScope = CoroutineScope(Dispatchers.Default)

    companion object {
        init {
            System.loadLibrary("xray")
        }
    }

    override fun onStartCommand(intent: Intent?, flags: Int, startId: Int): Int {
        serviceScope.launch {
            startVpn()
        }
        return START_STICKY
    }

    @TargetApi(Build.VERSION_CODES.LOLLIPOP)
    private fun startVpn() {
        try {
           
            val configFile = File(filesDir, "config.json")
            assets.open("config.json").use { input ->
                configFile.outputStream().use { output ->
                    input.copyTo(output)
                }
            }

           
            val result = startXray(configFile.absolutePath)
            if (result == 0) {
                
                vpnInterface = Builder()
                    .setSession("XrayVpnService")
                    .addAddress("10.0.0.2", 32)
                    .addRoute("0.0.0.0", 0)
                    .addDnsServer("8.8.8.8")
                    .addDisallowedApplication(packageName)
                    .establish()

           
                serviceScope.launch {
                    handleVpnTraffic()
                }
            } else {
                throw Exception("Failed to start Xray")
            }
        } catch (e: Exception) {
            e.printStackTrace()
            stopSelf()
        }
    }

    private suspend fun handleVpnTraffic() {
      
    }

    override fun onDestroy() {
        super.onDestroy()
        stopXray()
        vpnInterface?.close()
    }
}