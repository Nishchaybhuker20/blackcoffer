import 'dart:io';
import 'package:black_coffer/data/model/post.dart';
import 'package:black_coffer/presentation/home/ui/widgets/list_item.dart';
import 'package:black_coffer/presentation/home/ui/widgets/search.dart';
import 'package:black_coffer/presentation/player/ui/player_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  late Stream<QuerySnapshot<Map<String, dynamic>>> _videoStream;
  final TextEditingController searchController = TextEditingController();
  String searchKey = "";
  List<Post> posts = [];

  @override
  void initState() {
    super.initState();
    _videoStream = _getVideoStream();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: _videoStream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text("Error occurred");
          }
          if (snapshot.hasData && snapshot.data != null) {
            posts.clear();
            for (QueryDocumentSnapshot doc in snapshot.data!.docs) {
              Post post = Post.fromJson(doc.data() as Map<String, dynamic>);
              if (searchKey.isNotEmpty) {
                if (post.title
                    .toLowerCase()
                    .contains(searchKey.toLowerCase())) {
                  posts.add(post);
                }
              } else {
                posts.add(post);
              }
            }

            return CustomScrollView(
              slivers: [
                SliverAppBar(
                  backgroundColor: Colors.white,
                  toolbarHeight: 0,
                  elevation: 0,
                  floating: true,
                  bottom: SearchBar(
                    suffixIcon:
                        (searchKey.isEmpty) ? Icons.search : Icons.clear,
                    onClear: () {
                      setState(() {
                        searchKey = "";
                        searchController.text = searchKey;
                      });
                    },
                    controller: searchController,
                    context: context,
                    onChanged: (text) {
                      setState(() {
                        searchKey = text;
                      });
                    },
                  ),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, item) {
                      return Padding(
                        padding: const EdgeInsets.all(8),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return PlayerScreen(
                                  file: File(posts[item].filePath));
                            }));
                          },
                          child: ListItem(
                            post: posts[item],
                          ),
                        ),
                      );
                    },
                    childCount: posts.length,
                  ),
                ),
              ],
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> _getVideoStream() {
    return FirebaseFirestore.instance.collection("posts").snapshots();
  }
}
