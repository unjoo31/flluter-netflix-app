import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:video_player/video_player.dart';

class DetailScreen extends StatefulWidget {
  static String routeName = "/detail";

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  List<String> posters = [
    "assets/images/big_buck_bunny_poster.jpg",
    "assets/images/les_miserables_poster.jpg",
    "assets/images/minari_poster.jpg",
    "assets/images/the_book_of_fish_poster.jpg",
  ];

  late VideoPlayerController _videoPlayerController;
  ChewieController? _chewieController;

  // 비동기로 데이터를 불러오기 위해서 async / await를 사용함
  // Future : 지금은 데이터가 없지만 미래에 데이터가 있을 거라고 알려주는 클래스
  Future<void> initializePlayer() async {
    _videoPlayerController = VideoPlayerController.network(
        "https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4");
    await Future.wait([_videoPlayerController.initialize()]);
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      autoPlay: true,
    );
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    initializePlayer();
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        actions: [
          Icon(FontAwesomeIcons.search),
          SizedBox(width: 25.0),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 14.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5.0),
              child: Image(
                image: AssetImage("assets/images/dog.jpg"),
              ),
            ),
          ),
          SizedBox(width: 15.0),
        ],
      ),
      body: Column(
        children: [
          Container(
            height: 230.0,
            child: _chewieController != null &&
                    _chewieController!.videoPlayerController.value.isInitialized
                ? Chewie(controller: _chewieController!)
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      CircularProgressIndicator(),
                      SizedBox(height: 20),
                      Text('Loading'),
                    ],
                  ),
          ),
        ],
      ),
    );
  }
}
