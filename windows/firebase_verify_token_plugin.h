#ifndef FLUTTER_PLUGIN_FIREBASE_VERIFY_TOKEN_PLUGIN_H_
#define FLUTTER_PLUGIN_FIREBASE_VERIFY_TOKEN_PLUGIN_H_

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>

#include <memory>

namespace firebase_verify_token {

class FirebaseVerifyTokenPlugin : public flutter::Plugin {
 public:
  static void RegisterWithRegistrar(flutter::PluginRegistrarWindows *registrar);

  FirebaseVerifyTokenPlugin();

  virtual ~FirebaseVerifyTokenPlugin();

  // Disallow copy and assign.
  FirebaseVerifyTokenPlugin(const FirebaseVerifyTokenPlugin&) = delete;
  FirebaseVerifyTokenPlugin& operator=(const FirebaseVerifyTokenPlugin&) = delete;

  // Called when a method is called on this plugin's channel from Dart.
  void HandleMethodCall(
      const flutter::MethodCall<flutter::EncodableValue> &method_call,
      std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result);
};

}  // namespace firebase_verify_token

#endif  // FLUTTER_PLUGIN_FIREBASE_VERIFY_TOKEN_PLUGIN_H_
