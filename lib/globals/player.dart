import 'package:audioplayers/audioplayers.dart';

class PlayerMethod {
  AudioCache cache = AudioCache();
  AudioPlayer player = AudioPlayer();

  Future<AudioPlayer> playLocalAsset(String path, bool isLoop) async {
    cache.clearAll();
    if (isLoop) {
      return player = await cache.loop(path);
    } else {
      return player = await cache.play(path);
    }
  }

  void stop() {
    cache.clearAll();
    player.stop();
  }
}
