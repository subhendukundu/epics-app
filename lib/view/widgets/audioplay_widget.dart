import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:epics/controller/playaudio_ctrl.dart';
import 'package:epics/view/utils/SizedConfig.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart' hide AnimatedScale;
import 'package:marquee/marquee.dart';
import 'package:epics/view/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PlayAudioWidget extends StatelessWidget {
  const PlayAudioWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetX<PlayAudioController>(
        init: PlayAudioController(),
        builder: (controller) {
          print("PLAYING: ${controller.isPlaying.value}");
          return controller.isPlaying.value
              ? Stack(
                  children: [
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 90),
                        child: PhysicalModel(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(99),
                          elevation: 4,
                          child: Container(
                            height: SizeConfig.heightMultiplier * 7,
                            width: Get.width * 0.8,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                SizedBox(
                                  width: Get.width * 0.55,
                                  child: Marquee(
                                    text:
                                        controller.playingSongName.value + '\t',
                                    velocity: 20,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                PlayerBuilder.isPlaying(
                                    player: controller.assetsAudioPlayer,
                                    builder: (context, isPlaying) {
                                      return NeumorphicButton(
                                        onPressed: () => controller
                                            .assetsAudioPlayer
                                            .playOrPause(),
                                        style: const NeumorphicStyle(
                                            boxShape:
                                                NeumorphicBoxShape.circle(),
                                            color: Colors.white,
                                            shape: NeumorphicShape.concave),
                                        padding: EdgeInsets.all(8),
                                        child: Icon(
                                            isPlaying
                                                ? Icons.pause
                                                : Icons.play_arrow,
                                            color: PINK_COLOR),
                                      );
                                    }),
                              ],
                            ),
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(99),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 75,
                      left: 35,
                      child: Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                            image: DecorationImage(
                              image: NetworkImage(
                                  controller.playingSongImage.value),
                              fit: BoxFit.fill,
                            )),
                        height: Get.height * 0.12,
                        width: Get.height * 0.12,
                      ),
                    ),
                  ],
                )
              : SizedBox();
        });
  }
}
