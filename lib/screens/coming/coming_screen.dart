import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:video_player/video_player.dart';

class ComingScreen extends StatefulWidget {
  @override
  State<ComingScreen> createState() => _ComingScreenState();
}

class _ComingScreenState extends State<ComingScreen> {
  late VideoPlayerController _videoPlayerController;
  ChewieController? _chewieController;

  final List<String> genres = ["가슴 뭉쿨", "풍부한 감정", "권선징악", "영화"];

  Future<void> initializePlayer() async {
    _videoPlayerController = VideoPlayerController.network(
        'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4');
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
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        title: Text(
          "공개 예정",
          style: TextStyle(fontSize: 18.0),
        ),
        actions: [
          Icon(FontAwesomeIcons.chromecast),
          SizedBox(width: 25.0),
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
      body: ListView(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.3,
            child: _chewieController != null &&
                    _chewieController!.videoPlayerController.value.isInitialized
                ? Chewie(
                    controller: _chewieController!,
                  )
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
