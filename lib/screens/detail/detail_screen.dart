import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:netflix/constants.dart';
import 'package:netflix/models/episode.dart';
import 'package:netflix/screens/components/label_icon.dart';
import 'package:netflix/screens/components/play_button.dart';
import 'package:netflix/screens/components/small_sub_text.dart';
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
          Expanded(
            child: DefaultTabController(
              // DefaultTabController : 탭바를 사용하기 위해서 생성
              length: 2, // length 속성 : 2개의 탭바를 생성한다고 지정함
              child: NestedScrollView(
                // NestedScrollView : headerSliverBuilder와 body 두 개의 스크롤 영역으로 구분
                // headerSliverBuilder : 탭바를 기준으로 탭바까지 / body : 탭바의 상세화면이 들어있는 TabBarView까지 넣기
                headerSliverBuilder: (context, value) {
                  return [
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              " 빅 벅 버니",
                              style: TextStyle(fontSize: 24.0),
                            ),
                            SizedBox(height: 10.0),
                            Row(
                              children: [
                                Text(
                                  "95% 일치",
                                  style: TextStyle(
                                    fontSize: 12.0,
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(width: 10.0),
                                SmallSubText(text: "2008"),
                                SizedBox(width: 10.0),
                                Container(
                                  decoration: BoxDecoration(color: kLightColor),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 4.0, vertical: 2.0),
                                    child: Text(
                                      "15+",
                                      style: TextStyle(
                                          fontSize: 12.0,
                                          color: Colors.white60),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 10.0),
                                SmallSubText(text: "시즌 1개"),
                              ],
                            ),
                            SizedBox(height: 6.0),
                            Text(
                              "오늘 한국에서 콘텐츠 순위 1위",
                              style: TextStyle(fontSize: 16.0),
                            ),
                            SizedBox(height: 10.0),
                            PlayButton(width: double.infinity),
                            SizedBox(height: 10.0),
                            Container(
                              width: double.infinity,
                              height: 35.0,
                              decoration: BoxDecoration(
                                color: kButtonDarkColor,
                                borderRadius: BorderRadius.circular(4.0),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    FontAwesomeIcons.download,
                                    size: 16.0,
                                  ),
                                  SizedBox(width: 10.0),
                                  Text(
                                    "저장",
                                  )
                                ],
                              ),
                            ),
                            SizedBox(height: 10.0),
                            Text(episodes[0].description),
                            SizedBox(height: 6.0),
                            RichText(
                              text: TextSpan(
                                  text: "출연: ",
                                  style: TextStyle(
                                      fontSize: 12.0, color: Colors.grey[300]),
                                  children: [
                                    TextSpan(
                                        text: "버니, 프랭크, 링키, 기메라... ",
                                        style: TextStyle(color: Colors.grey)),
                                    TextSpan(text: "더보기"),
                                  ]),
                            ),
                            SizedBox(height: 20.0),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.6,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  LabelIcon(
                                    icon: FontAwesomeIcons.plus,
                                    label: "내가 찜한 콘텐츠",
                                  ),
                                  LabelIcon(
                                    icon: FontAwesomeIcons.thumbsUp,
                                    label: "평가",
                                  ),
                                  LabelIcon(
                                    icon: FontAwesomeIcons.shareAlt,
                                    label: "공유",
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SliverPadding(
                      padding: const EdgeInsets.only(top: 20.0),
                      sliver: SliverToBoxAdapter(
                        child: Container(
                          height: 50.0,
                          decoration: BoxDecoration(
                            border: Border(
                              top: BorderSide(color: kLightColor),
                            ),
                          ),
                          // TabBar는 하단에 보여지는 메뉴를 알려주는 선이 있음. indicator 옵션을 이용하여 이 선을 커스텀할 수 있음
                          child: TabBar(
                            indicator: UnderlineTabIndicator(
                              borderSide:
                                  BorderSide(color: Colors.red, width: 5.0),
                              insets: EdgeInsets.only(bottom: 45.0),
                            ),
                            isScrollable: true,
                            tabs: [
                              Tab(
                                text: "회차 정보",
                              ),
                              Tab(
                                text: "비슷한 콘텐츠",
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  ];
                },
                body: Container(
                  // TabBarView : 위에서 지정한 탭바의 개수와 자식의 개수가 동일해야함
                  child: TabBarView(
                    children: [
                      Container(),
                      Container(),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
