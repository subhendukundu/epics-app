import 'dart:async';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:epics/controller/add_post_Ctrl.dart';
import 'package:epics/view/utils/colors.dart';
import 'package:epics/view/utils/consts.dart';
import 'package:flutter/material.dart' hide Page;
import 'package:flutter_neumorphic/flutter_neumorphic.dart'
    hide Page
    hide AnimatedScale;
import 'package:get/get.dart';
import 'package:spotify/spotify.dart'
    hide Image
    hide PlayerContext
    hide Playlist;

import 'components/PLayingCtrl.dart';
import 'components/seekPosition.dart';

class SearchSong extends StatefulWidget {
  const SearchSong({
    Key key,
  }) : super(key: key);

  @override
  _SearchSongState createState() => _SearchSongState();
}

class _SearchSongState extends State<SearchSong> {
  static TextEditingController searchController = TextEditingController();
  AssetsAudioPlayer get _assetsAudioPlayer => AssetsAudioPlayer.withId('music');

  final List<StreamSubscription> _subscriptions = [];

  @override
  void initState() {
    super.initState();
    _subscriptions.add(_assetsAudioPlayer.playlistAudioFinished.listen((data) {
      print('playlistAudioFinished : $data');
    }));
    _subscriptions.add(_assetsAudioPlayer.audioSessionId.listen((sessionId) {
      print('audioSessionId : $sessionId');
    }));
    _subscriptions
        .add(AssetsAudioPlayer.addNotificationOpenAction((notification) {
      return true;
    }));
    // openPlayer();
  }

  Track playingTrack;
  @override
  void dispose() {
    _assetsAudioPlayer.dispose();
    print('dispose');
    super.dispose();
  }

  Audio find(List<Audio> source, String fromPath) {
    return source.firstWhere((element) => element.path == fromPath);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Search Song',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0,
      ),
      body: _sampleFlowWidget(context),
      bottomNavigationBar: _buildBottomBar(context),
    );
  }

  Widget _buildBottomBar(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: seekPosition(),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: bottomPanel(),
            )
          ],
        ),
      ],
    );
  }

  Widget seekPosition() {
    return _assetsAudioPlayer.builderRealtimePlayingInfos(
        builder: (context, RealtimePlayingInfos infos) {
      if (infos == null) {
        return SizedBox();
      }
      //print('infos: $infos');
      return infos.current != null
          ? Column(
              children: [
                GetBuilder<AddPostCtrl>(
                    init: AddPostCtrl(),
                    builder: (controller) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundImage: NetworkImage(
                                controller.playingTrack.album.images.first.url),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.5,
                            child: Text(
                              controller.playingTrack.name,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      );
                    }),
                PositionSeekWidget(
                  currentPosition: infos.currentPosition,
                  duration: infos.duration,
                  seekTo: (to) {
                    _assetsAudioPlayer.seek(to);
                  },
                ),
              ],
            )
          : SizedBox();
    });
  }

  Widget bottomPanel() {
    return _assetsAudioPlayer.builderCurrent(
        builder: (context, Playing playing) {
      return Column(children: <Widget>[
        _assetsAudioPlayer.builderLoopMode(
          builder: (context, loopMode) {
            return PlayerBuilder.isPlaying(
                player: _assetsAudioPlayer,
                builder: (context, isPlaying) {
                  return PlayingControls(
                    loopMode: loopMode,
                    isPlaying: isPlaying,
                    isPlaylist: true,
                    showSelectButton: true,
                    // onStop: () {
                    //   // Get.back();
                    //   _assetsAudioPlayer.stop();
                    // },
                    // toggleLoop: () {
                    //   _assetsAudioPlayer.toggleLoop();
                    // },
                    onPlay: () {
                      _assetsAudioPlayer.playOrPause();
                    },
                    // onNext: () {
                    //   //_assetsAudioPlayer.forward(Duration(seconds: 10));
                    //   _assetsAudioPlayer.next(keepLoopMode: true
                    //       /*keepLoopMode: false*/);
                    // },
                    // onPrevious: () {
                    //   _assetsAudioPlayer.previous(
                    //       /*keepLoopMode: false*/);
                    // },
                  );
                });
          },
        )
      ]);
    });
  }

  Widget _sampleFlowWidget(BuildContext context2) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: PhysicalModel(
            color: Colors.white,
            borderRadius: BorderRadius.circular(6),
            elevation: 1,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: TextField(
                controller: searchController,
                textAlignVertical: TextAlignVertical.center,
                decoration: InputDecoration(
                    hintText: 'Search a song',
                    border: InputBorder.none,
                    prefixIcon: Icon(Icons.search)),
                onChanged: (val) => setState(() {}),
              ),
            ),
          ),
        ),

        if (searchController.text != '')
          FutureBuilder<dynamic>(
            future: MusicService().searchSpotify(searchController.text),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Container(
                    height: MediaQuery.of(context).size.height * 0.3,
                    child: Center(child: CircularProgressIndicator()));
              }
              List<Page<dynamic>> list = snapshot.data;

              return Expanded(
                child: list[0].items.isNotEmpty
                    ? ListView.builder(
                        itemCount: list[0].items.length,
                        itemBuilder: (context, index) {
                          Track items = list.first.items.elementAt(index);

                          return Card(
                            elevation: 1,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                            margin: EdgeInsets.all(8.0),
                            child: GetX<AddPostCtrl>(
                                init: AddPostCtrl(),
                                builder: (controller) {
                                  print(controller.pickedSong.value);
                                  return ListTile(
                                    onTap: () async {
                                      if (items.previewUrl == null) {
                                        _assetsAudioPlayer.pause();
                                        // ignore: deprecated_member_use
                                        Scaffold.of(context).showSnackBar(
                                            SnackBar(
                                                content: Text(
                                                    'No PreviewUrl available')));
                                      } else {
                                        controller.pickedSong.value =
                                            !controller.pickedSong.value;
                                        controller.songPicked(items);
                                        FocusScope.of(context).unfocus();

                                        await _assetsAudioPlayer.open(
                                          Audio.network(items.previewUrl),
                                        );
                                      }

                                      // play(items.previewUrl!);
                                    },
                                    contentPadding: EdgeInsets.all(6.0),
                                    leading: CircleAvatar(
                                      backgroundImage: NetworkImage(
                                          items.album.images.first.url),
                                      radius: 35,
                                    ),
                                    title: Text(
                                      items.name,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    trailing: Padding(
                                      padding:
                                          const EdgeInsets.only(right: 8.0),
                                      child: Icon(
                                        Icons.play_arrow,
                                        color: PINK_COLOR,
                                      ),
                                    ),
                                    subtitle: Container(
                                      height: 17,
                                      child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: items.artists.length,
                                        itemBuilder: (context, index) {
                                          return Container(
                                              margin: EdgeInsets.only(right: 4),
                                              child: Text(
                                                items.artists[index].name,
                                                style: TextStyle(
                                                  color: Colors.grey,
                                                  fontWeight: FontWeight.w300,
                                                ),
                                              ));
                                        },
                                      ),
                                    ),
                                  );
                                }),
                          );
                        })
                    : Text(
                        'No result found for \n"${searchController.text}"',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
              );
            },
          ),
        // if (searchController.text == '') Text('No Data Found')
      ],
    );
  }
}

class MusicService {
  final credentials = SpotifyApiCredentials(CLIENT_ID, CLIENT_SECRET);

  Future<List<Page>> searchSpotify(String searchText) async {
    final spotify = SpotifyApi(credentials);
    final search = await spotify.search
        .get(
          searchText,
          types: [SearchType.track],
          market: 'IN',
        )
        .first(5)
        // ignore: invalid_return_type_for_catch_error
        .catchError((err) => print((err as SpotifyException).message));

    return search;
  }
}
