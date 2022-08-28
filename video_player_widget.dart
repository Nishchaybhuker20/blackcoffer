import 'dart:io';

import 'package:black_coffer/presentation/utils/video_player_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';

enum PlayerType {
  network,
  local,
}

class VideoPlayerWidget extends StatefulWidget {
  final File file;
  final PlayerType playerType;
  final double? height;

  const VideoPlayerWidget({
    Key? key,
    required this.file,
    required this.playerType,
    this.height,
  }) : super(key: key);

  @override
  _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late final VideoPlayerController _videoPlayerController;

  @override
  void initState() {
    super.initState();
    _videoPlayerController = widget.playerType == PlayerType.local
        ? VideoPlayerController.contentUri(Uri.parse(widget.file.path))
        : VideoPlayerController.network(widget.file.path);
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => VideoPlayerBloc(_videoPlayerController),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder(
            future: _videoPlayerController.initialize(),
            builder: (context, snapshot) {
              if (_videoPlayerController.value.hasError) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(_videoPlayerController.value.errorDescription
                        .toString()),
                  ),
                );
              }
              if (_videoPlayerController.value.isInitialized) {
                return GestureDetector(
                  onTap: () {
                    _videoPlayerController.value.isPlaying
                        ? _videoPlayerController.pause()
                        : _videoPlayerController.play();
                  },
                  child: BlocBuilder<VideoPlayerBloc, VideoPlayerState>(
                    builder: (context, playerState) {
                      return Stack(
                        alignment: Alignment.center,
                        children: [
                          widget.height == null
                              ? AspectRatio(
                                  aspectRatio:
                                      _videoPlayerController.value.aspectRatio,
                                  child: VideoPlayer(_videoPlayerController),
                                )
                              : SizedBox(
                                  width: double.infinity,
                                  height: widget.height,
                                  child: VideoPlayer(_videoPlayerController),
                                ),
                          (playerState is VideoPlayerPausedState)
                              ? Container(
                                  padding: const EdgeInsets.all(8.0),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: Colors.blue,
                                    shape: BoxShape.circle,
                                    border: Border.all(color: Colors.white),
                                  ),
                                  child: const Icon(
                                    Icons.play_arrow,
                                    color: Colors.white,
                                  ),
                                )
                              : const SizedBox(),
                        ],
                      );
                    },
                  ),
                );
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            }),
      ),
    );
  }
}
