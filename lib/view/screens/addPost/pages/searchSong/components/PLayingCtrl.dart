import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:epics/controller/add_post_Ctrl.dart';
import 'package:epics/view/utils/colors.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart' hide AnimatedScale;
import 'package:get/get.dart';

class PlayingControls extends StatelessWidget {
  final bool isPlaying;
  final LoopMode loopMode;
  final bool isPlaylist;
  final bool showSelectButton;
  // final Function() onPrevious;
  final Function() onPlay;
  // final Function() onNext;
  // final Function() toggleLoop;
  // final Function() onStop;

  const PlayingControls({
    this.isPlaying,
    this.isPlaylist = false,
    this.loopMode,
    // this.toggleLoop,
    // this.onPrevious,
    this.onPlay,
    this.showSelectButton,
    // this.onNext,
    // this.onStop,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        NeumorphicButton(
          style: const NeumorphicStyle(
            color: Colors.white,
            boxShape: NeumorphicBoxShape.circle(),
          ),
          padding: const EdgeInsets.all(12),
          onPressed: onPlay,
          child: Icon(
            isPlaying ? Icons.pause : Icons.play_arrow,
            size: 32,
            color: PINK_COLOR,
          ),
        ),
        SizedBox(height: 10),
        showSelectButton
            ? GetBuilder<AddPostCtrl>(
                init: AddPostCtrl(),
                builder: (controller) {
                  return NeumorphicButton(
                    style: const NeumorphicStyle(color: Colors.white),
                    onPressed: () {
                      controller.trackPickedForPost(controller.playingTrack);
                      controller.songPickedforPost.value = true;
                      Get.back();
                    },
                    child: const Text(
                      'Select',
                      style: TextStyle(
                        color: PINK_COLOR,
                      ),
                    ),
                  );
                })
            : SizedBox(),
      ],
    );
  }
}
