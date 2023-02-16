// ignore_for_file: avoid_unnecessary_containers
import 'package:TheatreTime/constants/theme_data.dart';
import 'package:TheatreTime/provider/darktheme_provider.dart';
import 'package:TheatreTime/provider/default_home_provider.dart';
import 'package:TheatreTime/provider/imagequality_provider.dart';
import 'package:TheatreTime/provider/mixpanel_provider.dart';
import 'package:TheatreTime/screens/discover.dart';
import 'package:TheatreTime/screens/landing_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '/screens/tv_widgets.dart';
import 'provider/adultmode_provider.dart';
import 'screens/common_widgets.dart';
import 'screens/movie_widgets.dart';
import 'screens/search_view.dart';
import 'screens/news_screen.dart';

DarkthemeProvider themeChangeProvider = DarkthemeProvider();
MixpanelProvider mixpanelProvider = MixpanelProvider();
ImagequalityProvider imagequalityProvider = ImagequalityProvider();
DeafultHomeProvider deafultHomeProvider = DeafultHomeProvider();
AdultmodeProvider adultmodeProvider = AdultmodeProvider();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterDownloader.initialize(debug: true, ignoreSsl: true);
  await themeChangeProvider.getCurrentThemeMode();
  await mixpanelProvider.initMixpanel();
  await adultmodeProvider.getCurrentAdultMode();
  await deafultHomeProvider.getCurrentDefaultScreen();
  await imagequalityProvider.getCurrentImageQuality();

  runApp(TheatreTime(
    theme: themeChangeProvider,
    mixpanel: mixpanelProvider,
    adult: adultmodeProvider,
    home: deafultHomeProvider,
    image: imagequalityProvider,
  ));
}

class TheatreTime extends StatefulWidget {
  const TheatreTime(
      {required this.theme,
      required this.mixpanel,
      required this.adult,
      required this.home,
      required this.image,
      Key? key})
      : super(key: key);
  final DarkthemeProvider theme;
  final MixpanelProvider mixpanel;
  final AdultmodeProvider adult;
  final DeafultHomeProvider home;
  final ImagequalityProvider image;

  @override
  State<TheatreTime> createState() => _TheatreTimeState();
}

class _TheatreTimeState extends State<TheatreTime>
    with ChangeNotifier, WidgetsBindingObserver {
  bool? isFirstLaunch;

  void firstTimeCheck() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      if (prefs.getBool('isFirstRun') == null) {
        isFirstLaunch = true;
      } else {
        isFirstLaunch = false;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    firstTimeCheck();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) {
            return widget.adult;
          }),
          ChangeNotifierProvider(create: (_) {
            return widget.theme;
          }),
          ChangeNotifierProvider(create: (_) {
            return widget.image;
          }),
          ChangeNotifierProvider(create: (_) {
            return widget.mixpanel;
          }),
          ChangeNotifierProvider(create: (_) {
            return widget.home;
          }),
        ],
        child: Consumer5<AdultmodeProvider, DarkthemeProvider,
                ImagequalityProvider, MixpanelProvider, DeafultHomeProvider>(
            builder: (context,
                adultmodeProvider,
                themeChangeProvider,
                imagequalityProvider,
                mixpanelProvider,
                defaultHomeProvider,
                snapshot) {
          final isDark = Provider.of<DarkthemeProvider>(context).darktheme;
          return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'TheatreTime',
              theme: Styles.themeData(themeChangeProvider.darktheme, context),
              home: isFirstLaunch == null
                  ? Scaffold(
                      body: Container(
                        color: isDark
                            ? const Color(0xFF202124)
                            : const Color(0xFFF7F7F7),
                        child: const Center(
                          child: SizedBox(
                              height: 50,
                              width: 50,
                              child: CircularProgressIndicator(
                                  color: Color(0xFF000000))),
                        ),
                      ),
                    )
                  : isFirstLaunch == true
                      ? const LandingScreen()
                      : const TheatreHomePage());
        }));
  }
}

class TheatreHomePage extends StatefulWidget {
  const TheatreHomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<TheatreHomePage> createState() => _TheatreHomePageState();
}

class _TheatreHomePageState extends State<TheatreHomePage>
    with SingleTickerProviderStateMixin {
  late int _selectedIndex;

  @override
  void initState() {
    defHome();
    super.initState();
  }

  void defHome() {
    final defaultHome =
        Provider.of<DeafultHomeProvider>(context, listen: false).defaultValue;
    setState(() {
      _selectedIndex = defaultHome;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Provider.of<DarkthemeProvider>(context).darktheme;
    final mixpanel = Provider.of<MixpanelProvider>(context).mixpanel;

    return Scaffold(
        drawer: const DrawerWidget(),
        appBar: AppBar(
          toolbarHeight: MediaQuery.of(context).size.height * 0.1,
          centerTitle: true,
          title: Text(
            'Theatre Time',
            style: TextStyle(
              fontFamily: 'PoppinsSB',
              fontSize: 25,
              color: isDark ? const Color(0xFFF7F7F7) : const Color(0xFF202124),
            ),
          ),
          leading: Builder(
            builder: (context) => IconButton(
              icon: Icon(
                Icons.menu,
                color:
                    isDark ? const Color(0xFFF7F7F7) : const Color(0xFF202124),
              ),
              onPressed: () => Scaffold.of(context).openDrawer(),
            ),
          ),
          actions: [
            IconButton(
                color:
                    isDark ? const Color(0xFFF7F7F7) : const Color(0xFF202124),
                onPressed: () {
                  showSearch(
                      context: context,
                      delegate: Search(
                          mixpanel: mixpanel,
                          includeAdult: Provider.of<AdultmodeProvider>(context,
                                  listen: false)
                              .isAdult));
                },
                icon: const Icon(Icons.search)),
          ],
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20)),
            color: Colors.transparent,
            boxShadow: [
              BoxShadow(
                blurRadius: 20,
                color: Colors.black.withOpacity(.1),
              )
            ],
          ),
          child: SafeArea(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
              child: GNav(
                rippleColor: Colors.grey[700]!,
                hoverColor: Colors.grey[100]!,
                gap: 8,
                activeColor: isDark
                    ? const Color(0xFFF7F7F7).withOpacity(0.5)
                    : const Color(0xFF202124),
                iconSize: 24,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                duration: const Duration(milliseconds: 400),
                tabBackgroundColor: Colors.transparent,
                color:
                    isDark ? const Color(0xFFF7F7F7) : const Color(0xFF202124),
                tabs: const [
                  GButton(
                    icon: FontAwesomeIcons.clapperboard,
                    text: 'Movies',
                  ),
                  GButton(
                    icon: FontAwesomeIcons.tv,
                    text: ' TV Shows',
                  ),
                  GButton(
                    icon: Icons.newspaper,
                    text: 'News',
                  ),
                  GButton(
                    icon: FontAwesomeIcons.compass,
                    text: 'Discover',
                  ),
                ],
                selectedIndex: _selectedIndex,
                onTabChange: (index) {
                  setState(() {
                    _selectedIndex = index;
                  });
                },
              ),
            ),
          ),
        ),
        body: Container(
          color: isDark ? const Color(0xFF202124) : const Color(0xFFF7F7F7),
          child: IndexedStack(
            index: _selectedIndex,
            children: const [
              MainMoviesDisplay(),
              MainTVDisplay(),
              NewsPage(),
              DiscoverPage(),
            ],
          ),
        ));
  }
}
