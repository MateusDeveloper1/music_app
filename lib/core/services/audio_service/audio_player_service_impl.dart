import 'package:audioplayers/audioplayers.dart';
import 'package:get/get.dart';
import 'package:music_app/core/services/audio_service/audio_player_service.dart';

class AudioPlayerServiceImpl extends GetxService implements AudioPlayerService {
  final AudioPlayer audioPlayer;

  AudioPlayerServiceImpl(this.audioPlayer);

  @override
  Future<int> get getCurrentPosition async {
    final position = await audioPlayer.getCurrentPosition();
    return position?.inSeconds ?? 0;
  }

  @override
  Stream<Duration> getPositionStream() {
    return audioPlayer.onPositionChanged;
  }

  @override
  Stream<void> onAudioComplete() {
    return audioPlayer.onPlayerComplete;
  }

  @override
  Future<void> pauseMusic() async {
    await audioPlayer.pause();
  }

  @override
  Future<void> plyaMusic(String audioAsset) async {
    await audioPlayer.play(AssetSource(audioAsset));
  }

  @override
  Future<void> resumeMusic() async {
    await audioPlayer.resume();
  }

  @override
  Future<void> seek(int seconds) {
    final seekTo = Duration(seconds: seconds);
    return audioPlayer.seek(seekTo);
  }

  @override
  Future<void> stopMusic() {
    return audioPlayer.stop();
  }

  @override
  void onClose() {
    audioPlayer
      ..stop()
      ..dispose();
    super.onClose();
  }
}
