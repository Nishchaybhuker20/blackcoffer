import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:video_player/video_player.dart';

part 'video_player_event.dart';

part 'video_player_state.dart';

class VideoPlayerBloc extends Bloc<VideoPlayerEvent, VideoPlayerState> {
  final VideoPlayerController _videoPlayerController;

  VideoPlayerBloc(this._videoPlayerController)
      : super(VideoPlayerPausedState()) {
    _videoPlayerController.addListener(() {
      if (_videoPlayerController.value.isPlaying) {
        add(VideoPlayingEvent());
      } else {
        add(VideoPausedEvent());
      }
    });
    on<VideoPlayingEvent>((event, emit) {
      emit(VideoPlayerPlayingState());
    });
    on<VideoPausedEvent>((event, emit) {
      emit(VideoPlayerPausedState());
    });
  }

  @override
  Future<void> close() {
    _videoPlayerController.removeListener(() {});
    return super.close();
  }
}
