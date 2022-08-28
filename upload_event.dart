part of 'upload_bloc.dart';

abstract class UploadInitialEvent extends Equatable {
  const UploadInitialEvent();
}

class UploadEvent extends UploadInitialEvent {
  final Reference reference;
  final Post post;

  const UploadEvent(this.reference, this.post);

  @override
  List<Object?> get props => [reference, post];
}

class UploadedEvent extends UploadInitialEvent {
  final Post post;

  const UploadedEvent(this.post);

  @override
  List<Object?> get props => [post];
}

class UploadingEvent extends UploadInitialEvent {
  final double progress;

  const UploadingEvent(this.progress);

  @override
  List<Object?> get props => [progress];
}
