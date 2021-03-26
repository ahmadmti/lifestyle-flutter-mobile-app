import 'package:flutter/material.dart';
import 'package:lifestyle/FitnessPlan/components/Header.dart';
import 'package:lifestyle/FitnessPlan/components/user_photo.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
int v;
YoutubePlayerController _controll;
class videoPlay extends StatefulWidget {
  videoPlay(int i)
  {
    v=i;
  }

  @override
  _videoPlayState createState() => _videoPlayState();
}

class _videoPlayState extends State<videoPlay> {

  // ignore: close_sinks
  YoutubePlayerController _controller = YoutubePlayerController(
    initialVideoId: 'g5oQZmk7xMc',
    params: YoutubePlayerParams(
      playlist: ['g5oQZmk7xMc', 'g5oQZmk7xMc'], // Defining custom playlist
      startAt: Duration(seconds: 30),
      showControls: true,
      showFullscreenButton: true,
    ),
  );
  // ignore: close_sinks
  YoutubePlayerController _controller2 = YoutubePlayerController(
    initialVideoId: 'ynUw0YsrmSg',
    params: YoutubePlayerParams(
      playlist: ['ynUw0YsrmSg', 'QBC732YLX9c','wZnsZsMywrY'], // Defining custom playlist
      startAt: Duration(seconds: 30),
      showControls: true,
      showFullscreenButton: true,
    ),
  );
  @override
  void initState() {
    if(v==0)
      {
        _controll= _controller;
      }
    else if(v==1)
      {
        _controll= _controller2;
      }


    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
        child: SafeArea(
        child: Container(
          padding: EdgeInsets.fromLTRB(2, 20, 2, 10),
            child: Column(
              children:<Widget> [
                Header(
                  'Fitness',
                  rightSide: UserPhoto(),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(10, 40, 10, 10),
                  child: YoutubePlayerIFrame(
                    controller: _controll,
                    aspectRatio: 9 / 16,
                  ),

                )

              ],
            ),

    ))));
  }
}
