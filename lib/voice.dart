import 'package:voice/proxy.dart';

import 'voice_platform_interface.dart';

class Voice {
  Future<String?> getPlatformVersion() {
    return VoicePlatform.instance.getPlatformVersion();
  }

  Future<String?> run(Proxy p) {
    return VoicePlatform.instance.run(p);
  }

  Future<String?> downApp(String pid) {
    return VoicePlatform.instance.downApp(pid);
  }
}
