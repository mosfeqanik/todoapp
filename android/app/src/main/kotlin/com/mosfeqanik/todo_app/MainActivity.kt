package com.mosfeqanik.todo_app
import io.flutter.embedding.android.FlutterActivity


class MainActivity: FlutterActivity() {
//    private val CHANNEL ="com.mosfeqanik.todo_app"
//    private lateinit var channel:MethodChannel
//    override fun configureFlutterEngine(flutterEngine:FlutterEngine){
//        super.configureFlutterEngine(flutterEngine)
//        channel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger,CHANNEL)
//        channel.setMethodCallHandler{
//                call,result->
//            if(call.method=="getMac"){
//                var mac = getMacAddress();
//                result.success(mac);
//                Toast.makeText(this,mac,Toast.LENGTH_LONG).show()
//            }
//        }
//    }
//    @TargetApi(Build.VERSION_CODES.GINGERBREAD)
//    private fun getMacAddress():String?{
//        try {
//            val all:List<NetworkInterface> = Collections.list<NetworkInterface>(NetworkInterface.getNetworkInterfaces())
//            for (nif in all){
//                if(!nif.name.equals("wlan0",ignoreCase = true))continue
//                val macBytes:ByteArray = nif.hardwareAddress?:return ""
//                val res1 = StringBuilder()
//                for (b in macBytes){
//                    res1.append(String.format("%02X:",b))
//                }
//                if (res1.length>0){
//                    res1.deleteCharAt(res1.length-1)
//                }
//                return res1.toString()
//            }
//        }catch (ex:java.lang.Exception){
//            Log.e("MAC_ADDRESS_ERROR", "Failed to get MAC address: ${ex.message}", ex)
//
//        }
//        return "02:00:00:00:00:00"
//    }
}
