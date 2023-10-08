import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:voice/proxy.dart';

import 'voice_platform_interface.dart';

/// An implementation of [VoicePlatform] that uses method channels.
class MethodChannelVoice extends VoicePlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('voice');

  @override
  Future<String?> getPlatformVersion() async {
    final version =
        await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

  @override
  Future<String?> run(Proxy p) async {
    final sayHi = await methodChannel.invokeMethod<String>(
      'run',
      {"port": p.port, 'name': p.name, 'ip': p.ip},
    );
    return sayHi;
  }

  @override
  Future<String?> downApp(String pid)async {
    final sayHi = await  methodChannel.invokeMethod<String>('downApp',{'pid':pid});
    return sayHi;
  }
}
