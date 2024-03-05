import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:netflix/screens/components/label_icon.dart';
import 'package:netflix/screens/components/play_button.dart';
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
    ScrollController _backController = new ScrollController();
    ScrollController _frontController = new ScrollController();

    return Stack(
      children: [
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
          child: CustomScrollView(
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
      ],
    );
  }
}
