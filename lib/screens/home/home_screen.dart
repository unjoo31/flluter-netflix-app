import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:netflix/screens/components/label_icon.dart';
import 'package:netflix/screens/components/play_button.dart';
import 'package:netflix/screens/components/small_sub_text.dart';
import 'package:netflix/screens/home/components/poster.dart';
import 'package:netflix/screens/home/components/rank_poster.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    Size appSize = MediaQuery.of(context).size;
    List<String> posters = [
      "assets/images/big_buck_bunny_poster.jpg",
      "assets/images/les_miserables_poster.jpg",
      "assets/images/minari_poster.jpg",
      "assets/images/the_book_of_fish_poster.jpg",
    ];
    // 1) 컨트롤러 추가하기
    // 스크롤 뷰 위치를 제어할 수 있는 컨트롤러
    ScrollController _backController = new ScrollController();
    ScrollController _frontController = new ScrollController();

    // 2) 전체 코드를 Stack으로 감싸기
    return Stack(
      children: [
        // 3) 배경(배너 영역)을 SingleChildScrollView로 만들어서 Stack의 첫번째 자식으로 추가하기
        SingleChildScrollView(
          controller: _backController,
          child: Column(
            children: [
              Stack(
                children: [
                  Image(
                    image: AssetImage(posters[0]),
                    height: appSize.height * 0.6 +
                        (SliverAppBar().toolbarHeight * 2),
                    width: double.infinity,
                    fit: BoxFit.fitWidth,
                  ),
                  Container(
                    height: appSize.height * 0.6 +
                        (SliverAppBar().toolbarHeight * 2),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withOpacity(0.2),
                          Colors.black.withOpacity(0.0),
                          Colors.black,
                        ],
                        stops: [0.0, 0.5, 0.9],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: appSize.height,
              ),
            ],
          ),
        ),
        SafeArea(
          // 4) 하단 영역의 경우 CustomScrollView를 NotificationListner로 감싸서 스크롤 이벤트를 감지할 수 있게 만들기
          child: NotificationListener(
            // 스크롤 이벤트가 일어날 때마다 스크롤 위치를 읽어줌
            onNotification: (ScrollNotification scrollInfo) {
              if (_frontController.offset <= appSize.height) {
                _backController.jumpTo(_frontController.offset);
                return true;
              } else {
                return false;
              }
            },
            child: CustomScrollView(
              // 5) CustomScrollView안에 controller 속성으로 컨트롤러 지정하기
              controller: _frontController,
              slivers: [
                SliverAppBar(
                  backgroundColor: Colors.transparent,
                  leading: Center(
                    child: Text(
                      "M",
                      style: TextStyle(
                        fontSize: 26.0,
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
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
                SliverAppBar(
                  titleTextStyle: TextStyle(fontSize: 18.0),
                  automaticallyImplyLeading: false,
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  pinned: true,
                  centerTitle: true,
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text("TV 프로그램"),
                      Text("영화"),
                      Text("내가 찜한 콘텐츠"),
                    ],
                  ),
                ),
                SliverToBoxAdapter(
                  child: GestureDetector(
                    // GestureDetector : 기본적으로 빈 공간이 아닌 위젯을 터치했을 때 동작함
                    // 빈 공간을 터치해도 영역 안이라면 이벤트가 일어나도록 하기 위해 옵션 지정함
                    behavior: HitTestBehavior.translucent,
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        // builder에서 리턴되는 위젯이 BottomSheet에 그려지게 됨
                        builder: _buildInfoBottomSheet,
                      );
                    },
                    child: Container(
                      height: (appSize.height * 0.6),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            "오늘 한국에서 콘텐츠 순위 1위",
                            style: TextStyle(fontSize: 16.0),
                          ),
                          SizedBox(height: 20.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              LabelIcon(
                                icon: FontAwesomeIcons.plus,
                                label: "내가 찜한 콘텐츠",
                              ),
                              PlayButton(width: 80.0),
                              LabelIcon(
                                icon: Icons.info_outline,
                                label: "내정보",
                              ),
                            ],
                          ),
                          SizedBox(height: 30.0),
                        ],
                      ),
                    ),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.only(bottom: 40.0, left: 10.0),
                  sliver: SliverToBoxAdapter(
                    child: Container(
                      height: 200.0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                            text: TextSpan(
                              text: "오늘 한국의 ",
                              children: [
                                TextSpan(
                                  text: "TOP 10",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                TextSpan(text: " 콘텐츠"),
                              ],
                              style: TextStyle(fontSize: 18.0),
                            ),
                          ),
                          SizedBox(height: 10.0),
                          Expanded(
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: List.generate(
                                posters.length,
                                (index) => RankPoster(
                                  rank: (index + 1).toString(),
                                  posterUrl: posters[index],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.only(bottom: 40.0, left: 10.0),
                  sliver: SliverToBoxAdapter(
                    child: Container(
                      height: 200.0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: "TV",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                TextSpan(text: "프로그램·로맨스"),
                              ],
                              style: TextStyle(fontSize: 18.0),
                            ),
                          ),
                          SizedBox(height: 10.0),
                          Expanded(
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: List.generate(
                                posters.length,
                                (index) => Poster(
                                  posterUrl: posters[index],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildInfoBottomSheet(BuildContext context) {
    // BottomSheet는 기본적으로 화면의 절반 정도를 차지함
    // 안의 내용만큼만 크기를 차지하도록 줄이고 싶을 때 Wrap으로 감싸주면 크기가 줄어듬
    return Wrap(
      children: [
        Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Color(0xFF2B2B2B),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  topRight: Radius.circular(10.0),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(5.0),
                          child: Image(
                            image: AssetImage(
                                "assets/images/big_buck_bunny_poster.jpg"),
                            width: 100.0,
                          ),
                        ),
                        SizedBox(width: 10.0),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "빅 벅 버니",
                                style: TextStyle(fontSize: 18.0),
                              ),
                              Row(
                                children: [
                                  SmallSubText(text: "2008"),
                                  SizedBox(width: 10.0),
                                  SmallSubText(text: "15+"),
                                  SizedBox(width: 10.0),
                                  SmallSubText(text: "시즌 1개"),
                                ],
                              ),
                              SizedBox(height: 8.0),
                              Text("버니가 좋아하는 나비들 중 2마리가 죽고 "
                                  "버니 자신에게 공격이 오자 "
                                  "버니는 온순한 자연을 뒤로 하고 "
                                  "2마리의 나비로 인해 복수할 계획들을 치밀히 세운다."),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        PlayButton(width: 160.0),
                        LabelIcon(
                          icon: FontAwesomeIcons.download,
                          label: "저장",
                          style: TextStyle(
                            fontSize: 12.0,
                            color: Colors.grey,
                          ),
                        ),
                        LabelIcon(
                          icon: FontAwesomeIcons.playCircle,
                          label: "미리보기",
                          style: TextStyle(fontSize: 12.0, color: Colors.grey),
                        ),
                      ],
                    ),
                    Divider(),
                    GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.info_outline),
                                  SizedBox(width: 10.0),
                                  Text("회차 및 상세정보"),
                                ],
                              ),
                              Icon(
                                FontAwesomeIcons.chevronRight,
                                size: 16.0,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              right: 10.0,
              top: 10.0,
              child: GestureDetector(
                onTap: () {
                  // BottomSheet는 자신의 외부 영역을 터치하면 닫힘
                  // 닫는 이벤트를 직접 지정하고 싶을 때는 Navigator.pop을 이용하기
                  Navigator.pop(context);
                },
                child: Container(
                  width: 30.0,
                  height: 30.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25.0),
                    color: Color(0xFF525252),
                  ),
                  child: Icon(FontAwesomeIcons.times),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
