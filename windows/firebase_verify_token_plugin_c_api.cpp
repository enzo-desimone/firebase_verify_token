#include "include/firebase_verify_token/firebase_verify_token_plugin_c_api.h"

#include <flutter/plugin_registrar_windows.h>

#include "firebase_verify_token_plugin.h"

void FirebaseVerifyTokenPluginCApiRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  firebase_verify_token::FirebaseVerifyTokenPlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}
