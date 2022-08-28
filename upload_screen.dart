import 'dart:io';

import 'package:black_coffer/data/model/post.dart';
import 'package:black_coffer/presentation/upload/logic/post_form_cubit.dart';
import 'package:black_coffer/presentation/upload/logic/upload_bloc.dart';
import 'package:black_coffer/presentation/utils/video_player_widget.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';

class PostVideoScreen extends StatefulWidget {
  final XFile xFile;
  final Position position;

  const PostVideoScreen({
    Key? key,
    required this.xFile,
    required this.position,
  }) : super(key: key);

  @override
  State<PostVideoScreen> createState() => _PostVideoScreenState();
}

class _PostVideoScreenState extends State<PostVideoScreen> {
  final TextEditingController _titleFieldController = TextEditingController();
  final TextEditingController _categoryFieldController =
      TextEditingController();
  final TextEditingController _descriptionFieldController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => PostFormCubit(),
        ),
      ],
      child: Scaffold(
        body: ListView(
          padding: const EdgeInsets.all(8.0),
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  padding: const EdgeInsets.all(4),
                  child: IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.cancel),
                  ),
                ),
              ],
            ),
            VideoPlayerWidget(
              file: File(widget.xFile.path),
              playerType: PlayerType.local,
            ),
            BlocBuilder<PostFormCubit, PostFormState>(
              builder: (context, state) {
                return TextFormField(
                  controller: _titleFieldController,
                  onChanged: (String value) {
                    context.read<PostFormCubit>().titleChanged(value);
                  },
                  decoration: InputDecoration(
                    errorText: state.isValidTitle ? null : "Can't be Empty",
                    hintText: "Title",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0)),
                  ),
                );
              },
            ),
            BlocBuilder<PostFormCubit, PostFormState>(
              builder: (context, state) {
                return TextFormField(
                  controller: _categoryFieldController,
                  onChanged: (String value) {
                    context.read<PostFormCubit>().categoryChanged(value);
                  },
                  decoration: InputDecoration(
                    hintText: "Category",
                    errorText: state.isValidCategory ? null : "Can't be Empty",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0)),
                  ),
                );
              },
            ),
            BlocBuilder<PostFormCubit, PostFormState>(
              builder: (context, state) {
                return TextFormField(
                  controller: _descriptionFieldController,
                  onChanged: (String value) {
                    context.read<PostFormCubit>().descriptionChanged(value);
                  },
                  decoration: InputDecoration(
                    hintText: "Description",
                    errorText:
                        state.isValidDescription ? null : "Can't be Empty",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0)),
                  ),
                );
              },
            ),
            TextFormField(
              readOnly: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                hintText:
                    "location: latitude: ${widget.position.latitude} longitude: ${widget.position.longitude}",
              ),
            ),
            BlocBuilder<UploadBloc, UploadState>(
              builder: (context, uploadState) {
                return BlocBuilder<PostFormCubit, PostFormState>(
                  builder: (context, formState) {
                    return ElevatedButton(
                      onPressed: () {
                        if (formState.isValidDescription &&
                            formState.isValidCategory &&
                            formState.isValidTitle) {
                          ScaffoldMessenger.of(context)
                            ..hideCurrentSnackBar()
                            ..showSnackBar(
                                const SnackBar(content: Text("Uploading...")));
                          Post post = Post(
                            filePath: widget.xFile.path,
                            title: _titleFieldController.text,
                            description: _descriptionFieldController.text,
                            location: Location(
                              latitude: widget.position.latitude.toString(),
                              longitude: widget.position.longitude.toString(),
                            ),
                            category: _categoryFieldController.text,
                          );

                          Reference reference = FirebaseStorage.instance.ref(
                              "${DateTime.now().millisecondsSinceEpoch.toString()}.mp4");

                          context
                              .read<UploadBloc>()
                              .add(UploadEvent(reference, post));
                          Navigator.of(context).pop();
                        }
                      },
                      child: const Text("Post"),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
