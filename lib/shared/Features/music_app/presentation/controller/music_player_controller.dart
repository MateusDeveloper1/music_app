import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_app/core/services/audio_service/audio_player_service.dart';
import 'package:music_app/shared/models/music_model.dart';

import '../../../../../core/errors/exception.dart';
import '../../../../../core/mixins/snackbar_mixin.dart';

class MusicPlayerController with SnackBarMixin {
  final AudioPlayerService _audioPlayer;

  MusicPlayerController(AudioPlayerService audioPlayer)
      : _audioPlayer = audioPlayer {
    //Ouve quando a música acabar para então pular para proxima musica
    _audioCompleteStreamSubscription =
        _audioPlayer.onAudioComplete().listen((event) {
      skipTrack();
    });
  }

  StreamSubscription? _audioCompleteStreamSubscription;

  final RxBool isPlaying = false.obs;

  final RxInt currentMusicDuration = 0.obs;

  final RxnInt currentMusicIndexPlaying = RxnInt();

  int? get getCurrentMusicIndexPlaying => currentMusicIndexPlaying.value;

  final RxList<MusicModel> _playListPlaying = <MusicModel>[].obs;

  List<MusicModel> get getPlayListPlaying => _playListPlaying;

  final List<MusicModel> selectedPlayList = [];

  Stream<Duration> get getCurrentPositionStream =>
      _audioPlayer.getPositionStream();

  Future<void> seek(int seekToDurationSeconds) =>
      _audioPlayer.seek(seekToDurationSeconds);

  void loadPlaylist(
      List<MusicModel> newPlaylist, List<MusicModel> playlistToChange) {
    playlistToChange
      ..clear()
      ..addAll(newPlaylist);
  }

  Future<void> onCallMusicPlayerTryAndCatchFucntion(
      Future<void> Function() tryFunction) async {
    try {
      await tryFunction();
    } on AudioPlayersException catch (error) {
      showErrorSnackBar(error.message);
    }
  }

  Future<void> playMusic(String url) async {
    return onCallMusicPlayerTryAndCatchFucntion(() async {
      isPlaying.value = true;
      await _audioPlayer.plyaMusic(url);
    });
  }

  Future<void> stopMusic() async {
    return onCallMusicPlayerTryAndCatchFucntion(() async {
      isPlaying.value = false;
      await _audioPlayer.stopMusic();
    });
  }

  Future<void> loadMusic() async {
    return onCallMusicPlayerTryAndCatchFucntion(() async {
      loadPlaylist(selectedPlayList, _playListPlaying);

      await stopMusic();

      await playMusic(_playListPlaying[getCurrentMusicIndexPlaying ?? 0].url);
    });
  }

  Future<void> pauseMusic() async {
    return onCallMusicPlayerTryAndCatchFucntion(() async {
      isPlaying.value = false;

      await _audioPlayer.pauseMusic();
    });
  }

  Future<void> skipTrack() async {
    if(getCurrentMusicIndexPlaying != null){
      if(getCurrentMusicIndexPlaying! < _playListPlaying.length - 1){
        currentMusicIndexPlaying.value = currentMusicIndexPlaying.value! + 1;
      } else {
        currentMusicIndexPlaying.value = 0;
      }
      await loadMusic();
    }
  }

  MusicModel? get getCurrentPlayingMusic {
    if(getCurrentMusicIndexPlaying != null) {
      return _playListPlaying[getCurrentMusicIndexPlaying!];
      
    }
    return null;
  }

  Future<void> backTrack() async {
    if(getCurrentMusicIndexPlaying != null && getCurrentMusicIndexPlaying! > 0) {
      currentMusicIndexPlaying.value = currentMusicIndexPlaying.value! - 1;
    } else {
      currentMusicIndexPlaying.value = _playListPlaying.length - 1;
    }

    await loadMusic();
  }

  void dispose(){
    _audioCompleteStreamSubscription?.cancel();
  }

  Future<void> loadCurrentMusicDuration() async {
    if(!isPlaying.value){
      currentMusicDuration.value = await _audioPlayer.getCurrentPosition;
    }
  }

  void playSelectedMusic(BuildContext context, int musicIndex) {
    currentMusicIndexPlaying.value = musicIndex;
    loadMusic();
    showMusicPlayer(context);
  }

  Future<void> showMusicPlayer(BuildContext context) async {}

}
