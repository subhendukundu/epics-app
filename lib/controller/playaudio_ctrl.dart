import 'package:epics/model/models/post_model.dart';
import 'package:get/get.dart';
import 'package:assets_audio_player/assets_audio_player.dart';

class PlayAudioController extends GetxController {
  AssetsAudioPlayer get assetsAudioPlayer => AssetsAudioPlayer.withId('music');
  RxString playingSongName = ''.obs;
  RxString playingSongImage = ''.obs;
  RxBool isPlaying = false.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() async {
    super.onClose();
    print('CONTROLLER CLOSED');
    if (isPlaying.value) {
      print(isPlaying.value);

      await assetsAudioPlayer.dispose().then((value) {
        isPlaying.value = false;
      });
    }
  }

  playAudio(PostsModel postmodel) async {
    playingSongName.value = postmodel.songName;
    playingSongImage.value = postmodel.songImage;
    isPlaying.value = true;
    await assetsAudioPlayer.open(
      Audio.network(postmodel.songUrl),
    );
  }

  // Widget buildBottomBar(BuildContext context, PostsModel postmodel) {
  //   return Column(
  //     mainAxisSize: MainAxisSize.min,
  //     children: [
  //       Row(
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         children: <Widget>[
  //           Padding(
  //             padding: const EdgeInsets.all(8.0),
  //             child: seekPosition(postmodel.songImage, postmodel.songName),
  //           ),
  //           Padding(
  //             padding: const EdgeInsets.all(8.0),
  //             child: bottomPanel(),
  //           )
  //         ],
  //       ),
  //     ],
  //   );
  // }

  // Widget seekPosition(String songImage, String songName) {
  //   playingSongName.value = songName;
  //   playingSongImage.value = songImage;
  //   isPlaying.value = true;
  //   return assetsAudioPlayer.builderRealtimePlayingInfos(
  //       builder: (context, RealtimePlayingInfos infos) {
  //     if (infos == null) {
  //       return SizedBox();
  //     }
  //     //print('infos: $infos');
  //     return infos.current != null
  //         ? Column(
  //             children: [
  //               Row(
  //                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //                 children: [
  //                   CircleAvatar(
  //                     radius: 30,
  //                     backgroundImage: NetworkImage(songImage),
  //                   ),
  //                   SizedBox(
  //                     width: 20,
  //                   ),
  //                   SizedBox(
  //                     width: MediaQuery.of(context).size.width * 0.5,
  //                     child: Text(
  //                       songName,
  //                       overflow: TextOverflow.ellipsis,
  //                       style: TextStyle(
  //                         color: Colors.black,
  //                         fontWeight: FontWeight.bold,
  //                       ),
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //               PositionSeekWidget(
  //                 currentPosition: infos.currentPosition,
  //                 duration: infos.duration,
  //                 seekTo: (to) {
  //                   assetsAudioPlayer.seek(to);
  //                 },
  //               ),
  //             ],
  //           )
  //         : SizedBox();
  //   });
  // }

  // Widget bottomPanel() {
  //   return assetsAudioPlayer.builderCurrent(
  //       builder: (context, Playing playing) {
  //     return Column(children: <Widget>[
  //       assetsAudioPlayer.builderLoopMode(
  //         builder: (context, loopMode) {
  //           return PlayerBuilder.isPlaying(
  //               player: assetsAudioPlayer,
  //               builder: (context, isPlaying) {
  //                 return PlayingControls(
  //                   loopMode: loopMode,
  //                   isPlaying: isPlaying,
  //                   isPlaylist: true,
  //                   showSelectButton: false,
  //                   onPlay: () {
  //                     assetsAudioPlayer.playOrPause();
  //                   },
  //                 );
  //               });
  //         },
  //       )
  //     ]);
  //   });
  // }
}
