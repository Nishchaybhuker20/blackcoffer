import 'dart:async';
import 'dart:io';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:black_coffer/data/model/post.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'upload_event.dart';

part 'upload_state.dart';

class UploadBloc extends Bloc<UploadInitialEvent, UploadState> {
  late StreamSubscription _fileStreamSubscription;

  UploadBloc() : super(UploadInitialState()) {
    on<UploadEvent>((event, emit) {
      UploadTask _uploadTask =
          event.reference.putFile(File(event.post.filePath));
      _uploadTask.whenComplete(() async {
        Post post = Post(
          filePath: await event.reference.getDownloadURL(),
          title: event.post.title,
          description: event.post.description,
          location: event.post.location,
          category: event.post.category,
        );
        await FirebaseFirestore.instance.collection("posts").add(post.toJson());
        add(UploadedEvent(post));
      });
      _fileStreamSubscription =
          _uploadTask.snapshotEvents.listen((taskSnapshot) {
        double progress =
            (taskSnapshot.bytesTransferred / taskSnapshot.totalBytes) * 100;
        AwesomeNotifications().createNotification(
          content: NotificationContent(
            displayOnForeground: true,
            category: NotificationCategory.Progress,
            notificationLayout: NotificationLayout.ProgressBar,
            color: Colors.blue,
            id: 10,
            locked: !(progress >= 100),
            channelKey: "notification_channel_key",
            title: progress >= 100 ? "Video uploaded" : "Uploading",
            progress: progress.toInt(),
          ),
        );
        add(UploadingEvent(progress));
      });
      on<UploadingEvent>((event, emit) {
        emit(UploadingState(event.progress.ceilToDouble()));
      });
      on<UploadedEvent>((event, emit) async {
        emit(UploadedState(event.post));
      });
    });
  }

  @override
  Future<void> close() {
    _fileStreamSubscription.cancel();
    return super.close();
  }
}
