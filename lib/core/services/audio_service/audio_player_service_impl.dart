import 'dart:developer';

import 'package:audioplayers/audioplayers.dart';
import 'package:get/get.dart';
import 'package:music_app/core/errors/exception.dart';
import 'package:music_app/core/services/audio_service/audio_player_service.dart';

class AudioPlayerServiceImpl extends GetxService implements AudioPlayerService {
  final AudioPlayer audioPlayer;

  AudioPlayerServiceImpl(this.audioPlayer);

  @override
  Future<int> get getCurrentPosition async {
    try {
      final position = await audioPlayer.getCurrentPosition();
      return position?.inSeconds ?? 0;
    } catch (error, stackTrace) {
      const errorMessage = "Erro ao pegar posição da música";
      log(errorMessage, error: error, stackTrace: stackTrace);

      throw AudioPlayersException(message: errorMessage);
    }
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
    try {
      await audioPlayer.pause();
    } catch (error, stackTrace) {
      const errorMessage = "Erro ao pausar a música";
      log(errorMessage, error: error, stackTrace: stackTrace);

      throw AudioPlayersException(message: errorMessage);
    }
  }

  @override
  Future<void> plyaMusic(String audioAsset) async {
    try {
      await audioPlayer.play(AssetSource(audioAsset));
    } catch (error, stackTrace) {
      const errorMessage = "Erro ao carregar a música";
      log(errorMessage, error: error, stackTrace: stackTrace);

      throw AudioPlayersException(message: errorMessage);
    }
  }

  Future<void> callAudioPlayerServiceTryAndCatchFunction(
      Future<void> Function() tryFunction,
      String audioPlayersExceptionMessage) async {
    try {
      await tryFunction();
    } catch (error, stackTrace) {
      final errorMessage = audioPlayersExceptionMessage;

      log(errorMessage, error: error, stackTrace: stackTrace);

      throw AudioPlayersException(message: errorMessage);
    }
  }

  @override
  Future<void> resumeMusic() async {
    return callAudioPlayerServiceTryAndCatchFunction(
        () => audioPlayer.resume(), "Erro ao continuar a música");
  }

  @override
  Future<void> seek(int seconds) {
    return callAudioPlayerServiceTryAndCatchFunction(
      () {
        final seekTo = Duration(seconds: seconds);
        return audioPlayer.seek(seekTo);
      },
      "Erro ao tocar a música",
    );
  }

  @override
  Future<void> stopMusic() {
    return callAudioPlayerServiceTryAndCatchFunction(
      () => audioPlayer.stop(),
      "Erro ao parar a música",
    );
  }

  @override
  void onClose() {
    audioPlayer
      ..stop()
      ..dispose();
    super.onClose();
  }
}
