import 'package:TheatreTime/provider/darktheme_provider.dart';
import 'package:TheatreTime/screens/discover_movies_tab.dart';
import 'package:TheatreTime/screens/discover_tv_tab.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DiscoverPage extends StatefulWidget {
  const DiscoverPage({Key? key}) : super(key: key);

  @override
  State<DiscoverPage> createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Provider.of<DarkthemeProvider>(context).darktheme;
    return Column(
      children: [
        Container(
          color: isDark ? const Color(0xFF202124) : const Color(0xFFF7F7F7),
          width: double.infinity,
          child: TabBar(
            tabs: [
              Tab(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Icon(
                        Icons.movie_creation_rounded,
                        color: isDark
                            ? const Color(0xFFF7F7F7)
                            : const Color(0xFF202124),
                      ),
                    ),
                    Text(
                      'Movies',
                      style: TextStyle(
                          color: isDark
                              ? const Color(0xFFF7F7F7)
                              : const Color(0xFF202124),
                          fontFamily: 'PoppinsSB',
                          fontSize: 18),
                    ),
                  ],
                ),
              ),
              Tab(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                        padding: EdgeInsets.only(right: 8.0),
                        child: Icon(
                          Icons.live_tv_rounded,
                          color: isDark
                              ? const Color(0xFFF7F7F7)
                              : const Color(0xFF202124),
                        )),
                    Text(
                      'TV Series',
                      style: TextStyle(
                          color: isDark
                              ? const Color(0xFFF7F7F7)
                              : const Color(0xFF202124),
                          fontFamily: 'PoppinsSB',
                          fontSize: 18),
                    ),
                  ],
                ),
              ),
            ],
            indicatorColor: isDark ? Colors.white : Colors.black,
            indicatorWeight: 3,
            //isScrollable: true,
            labelStyle: const TextStyle(
              fontFamily: 'PoppinsSB',
              color: Colors.black,
              fontSize: 17,
            ),
            unselectedLabelStyle:
                const TextStyle(fontFamily: 'Poppins', color: Colors.black87),
            labelColor: Colors.black,
            controller: tabController,
            indicatorSize: TabBarIndicatorSize.tab,
          ),
        ),
        Expanded(
          child: TabBarView(
            controller: tabController,
            children: const [DiscoverMoviesTab(), DiscoverTVTab()],
          ),
        )
      ],
    );
  }
}
