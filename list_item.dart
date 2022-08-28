import 'package:black_coffer/data/model/post.dart';
import 'package:black_coffer/presentation/utils/video_player_widget.dart';
import 'package:flutter/material.dart';

class ListItem extends StatelessWidget {
  final Post post;

  const ListItem({
    Key? key,
    required this.post,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          alignment: Alignment.center,
          height: 180,
          width: double.infinity,
          color: Colors.black,
          child: Container(
            height: 40,
            width: 40,
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
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const CircleAvatar(
              backgroundColor: Colors.black,
            ),
            Text(post.title),
            Text(post.category),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
            "latitude: ${post.location.latitude} longitude: ${post.location.longitude}"),
      ],
    );
  }
}
