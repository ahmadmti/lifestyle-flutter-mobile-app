import 'package:flutter/material.dart';
import 'package:lifestyle/FitnessPlan/components/Header.dart';
import 'package:lifestyle/FitnessPlan/components/user_photo.dart';
import 'package:lifestyle/FitnessPlan/models/exercise.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

int v;
Exercise exercise;
YoutubePlayerController _controll;

class videoPlay extends StatefulWidget {
  videoPlay(exer, int i) {
    v = i;
    exercise = exer;
  }

  @override
  _videoPlayState createState() => _videoPlayState();
}

class _videoPlayState extends State<videoPlay> {
  // ignore: close_sinks
  YoutubePlayerController _controller = YoutubePlayerController(
    initialVideoId: '${exercise.link}',
    params: YoutubePlayerParams(
      playlist: ['${exercise.link}', '${exercise.link}'], // Defining custom playlist
      startAt: Duration(seconds: 30),
      showControls: true,
      showFullscreenButton: true,
    ),
  );

  void initState() {
    _controll = _controller;
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
        children: <Widget>[
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
