import 'dart:ffi';

import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:voice_proxy/proxy.dart';

import 'voice_method_channel.dart';

abstract class VoicePlatform extends PlatformInterface {
  /// Constructs a VoicePlatform.
  VoicePlatform() : super(token: _token);

  static final Object _token = Object();

  static VoicePlatform _instance = MethodChannelVoice();

  /// The default instance of [VoicePlatform] to use.
  ///
  /// Defaults to [MethodChannelVoice].
  static VoicePlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [VoicePlatform] when
  /// they register themselves.
  static set instance(VoicePlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
  Future<String?> run(Proxy params) {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<String?> downApp(String pid) {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
