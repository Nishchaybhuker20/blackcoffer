import 'dart:io';

import 'package:black_coffer/presentation/utils/video_player_widget.dart';
import 'package:flutter/material.dart';

class PlayerScreen extends StatelessWidget {
  final File file;

  const PlayerScreen({Key? key, required this.file}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
          VideoPlayerWidget(
            file: file,
            playerType: PlayerType.network,
          ),
        ],
      ),
    );
  }
}
