part of 'video_player_bloc.dart';

abstract class VideoPlayerEvent extends Equatable {
  const VideoPlayerEvent();
}

class VideoPlayingEvent extends VideoPlayerEvent {
  @override
  List<Object?> get props => [];
}

class VideoPausedEvent extends VideoPlayerEvent {
  @override
  List<Object?> get props => [];
}
