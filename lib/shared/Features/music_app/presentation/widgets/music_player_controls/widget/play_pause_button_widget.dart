import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/instance_manager.dart';
import 'package:music_app/core/app/music_app_colors.dart';
import 'package:music_app/shared/Features/music_app/presentation/controller/music_player_controller.dart';

enum PlayPauseButtonSize { small, normal }

class PlayPauseButtoWidget extends StatelessWidget {
  final String? musicUrl;
  final PlayPauseButtonSize _playPauseButtonSize;

  const PlayPauseButtoWidget({
    this.musicUrl,
    PlayPauseButtonSize? playPauseButtoSize,
    super.key,
  }) : _playPauseButtonSize = playPauseButtoSize ?? PlayPauseButtonSize.normal;

  @override
  Widget build(BuildContext context) {
    final musicPlayerCtrl = Get.find<MusicPlayerController>();

    return Obx(
      () => IconButton(
        iconSize: _playPauseButtonSize == PlayPauseButtonSize.normal ? 70 : 50,
        onPressed: () async {
          if (musicUrl != null) {
            if (musicPlayerCtrl.isPlaying.value) {
              musicPlayerCtrl.pauseMusic();
            } else {
              musicPlayerCtrl.playMusic(musicUrl!);
            }
          }
        },
        icon: Icon(
          musicPlayerCtrl.isPlaying.value
              ? Icons.pause_circle
              : Icons.play_circle,
          color: MusicAppColors.secondaryColor,
        ),
        padding: const EdgeInsets.all(0),
      ),
    );
  }
}
