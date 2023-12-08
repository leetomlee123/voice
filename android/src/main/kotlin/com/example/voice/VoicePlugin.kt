package com.example.voice

import androidx.annotation.NonNull
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import mobile.Mobile
import kotlinx.coroutines.*
import java.lang.Exception

/** VoicePlugin */
class VoicePlugin : FlutterPlugin, MethodCallHandler {
    /// The MethodChannel that will the communication between Flutter and native Android
    ///
    /// This local reference serves to register the plugin with the Flutter Engine and unregister it
    /// when the Flutter Engine is detached from the Activity
    private lateinit var channel: MethodChannel
    private lateinit var job: Job


    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "voice")
        channel.setMethodCallHandler(this)
    }

    public suspend fun runProxy(port: String?, name: String?, ip: String?) {
        try {
            Mobile.run(port, name, ip)
        }catch (e:Exception){
            println(e.message)
        }
    }

    override fun onMethodCall(call: MethodCall, result: Result) {
        if (call.method == "getPlatformVersion") {
            result.success("Android ${android.os.Build.VERSION.RELEASE}")
        } else if (call.method == "run") {
            var port: String? = call.argument<String>("port")
            var name: String? = call.argument<String>("name")
            var ip: String? = call.argument<String>("ip")
//            println(job==null)
//            val cancel = job?.cancel()
            job = CoroutineScope(Dispatchers.IO).launch {
                    runProxy(port, name, ip)
                }

//            print(ip)
//            suspend fun getImage(port: String?,name: String?,ip: String?,)  {
//                 withContext(Dispatchers.IO) {
//                    Mobile.run(port, name, ip)
//                }
//            }
//            getImage(port,name,ip)

//            var pid:String= Mobile.run(port, name, ip)
            result.success("ok");
        } else if (call.method == "downApp") {
            job.cancel()


        } else {
            result.notImplemented()
        }
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }
}
