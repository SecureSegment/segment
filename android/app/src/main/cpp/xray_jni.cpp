#include <jni.h>
#include <string>
#include "xray_core.h" 

extern "C" {

JNIEXPORT jint JNICALL
Java_com_example_segment_XrayVpnService_startXray(JNIEnv *env, jobject /* this */, jstring configPath) {
    const char *nativeConfigPath = env->GetStringUTFChars(configPath, 0);
    
   
    int result = xray_core_start(nativeConfigPath);
    
    env->ReleaseStringUTFChars(configPath, nativeConfigPath);
    return result;
}

JNIEXPORT jint JNICALL
Java_com_example_segment_XrayVpnService_stopXray(JNIEnv *env, jobject /* this */) {
   
    return xray_core_stop();
}

}