import 'package:flutter_test/flutter_test.dart';
import 'package:voice/voice.dart';
import 'package:voice/voice_platform_interface.dart';
import 'package:voice/voice_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockVoicePlatform
    with MockPlatformInterfaceMixin
    implements VoicePlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final VoicePlatform initialPlatform = VoicePlatform.instance;

  test('$MethodChannelVoice is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelVoice>());
  });

  test('getPlatformVersion', () async {
    Voice voicePlugin = Voice();
    MockVoicePlatform fakePlatform = MockVoicePlatform();
    VoicePlatform.instance = fakePlatform;

    expect(await voicePlugin.getPlatformVersion(), '42');
  });
}
