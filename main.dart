import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:black_coffer/core/bloc_observer.dart';
import 'package:black_coffer/presentation/app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  AwesomeNotifications().initialize(
    null,
    [
      NotificationChannel(
        channelKey: 'notification_channel_key',
        channelName: 'notifications',
        channelDescription: 'Notification channel description',
      )
    ],
  );

  AwesomeNotifications()
      .requestPermissionToSendNotifications()
      .then((value) => debugPrint(value.toString()));

  BlocOverrides.runZoned(
    () => runApp(const MyApp()),
    blocObserver: Observer(),
  );
}
