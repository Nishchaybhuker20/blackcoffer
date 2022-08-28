part of 'video_player_bloc.dart';

abstract class VideoPlayerState extends Equatable {
  const VideoPlayerState();
}

class VideoPlayerPausedState extends VideoPlayerState {
  @override
  List<Object> get props => [];
}

class VideoPlayerPlayingState extends VideoPlayerState {
  @override
  List<Object> get props => [];
}
