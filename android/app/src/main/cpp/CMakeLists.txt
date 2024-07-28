cmake_minimum_required(VERSION 3.18.1)

add_library(xray SHARED
            xray_jni.cpp)

find_library(log-lib
             log)

target_link_libraries(xray
                      ${log-lib}
                      
                      )