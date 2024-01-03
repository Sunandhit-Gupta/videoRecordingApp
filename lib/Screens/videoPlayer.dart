import 'dart:io';

import 'package:appinio_video_player/appinio_video_player.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_recording_app/main.dart';

class videoPlayer extends StatefulWidget {

  @override
  bool get wantKeepAlive => true;

  final XFile? videoFileSource;
  
  const videoPlayer({this.videoFileSource,});

  @override
  State<videoPlayer> createState() => _videoPlayerState();
}

class _videoPlayerState extends State<videoPlayer> {

  @override
  bool get wantKeepAlive => true;

  late CustomVideoPlayerController customVideoPlayerController;
  String assetPath = "assets/vid.mp4";
  @override
  void initState() {
    super.initState();
    initializeVideoPlayer(widget.videoFileSource);
  }
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [

          Center(child: CustomVideoPlayer(customVideoPlayerController: customVideoPlayerController)),
        ],
      ),
    );
  }

  void initializeVideoPlayer(source )
  {
    double? ratio = 1/1;
    if(myIndex == 2)
    {
      ratio = 1/1;
    }
    CustomVideoPlayerSettings customVideoPlayerSettings =  CustomVideoPlayerSettings(customAspectRatio: ratio);
    VideoPlayerController videoPlayerController ;
    videoPlayerController =  VideoPlayerController.file(File(source.path))..initialize().then((value){ setState(() {
    });});
    customVideoPlayerController = CustomVideoPlayerController(context: context, videoPlayerController: videoPlayerController,
    customVideoPlayerSettings: customVideoPlayerSettings
    );
  }
}