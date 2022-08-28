part of 'upload_bloc.dart';

abstract class UploadState extends Equatable {
  const UploadState();
}

class UploadInitialState extends UploadState {
  @override
  List<Object> get props => [];
}

class UploadingState extends UploadState {
  final double progress;

  const UploadingState(this.progress);

  @override
  List<Object> get props => [progress];
}

class UploadedState extends UploadState {
  final Post post;

  const UploadedState(this.post);

  @override
  List<Object> get props => [post];
}
