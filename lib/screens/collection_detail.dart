import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/api/endpoints.dart';
import '/constants/api_constants.dart';
import '/models/movie.dart';
import '/screens/movie_widgets.dart';
import '../constants/app_constants.dart';
import '../provider/darktheme_provider.dart';
import '../provider/imagequality_provider.dart';

class CollectionDetailsWidget extends StatefulWidget {
  final BelongsToCollection? belongsToCollection;

  const CollectionDetailsWidget({
    Key? key,
    this.belongsToCollection,
  }) : super(key: key);
  @override
  CollectionDetailsWidgetState createState() => CollectionDetailsWidgetState();
}

class CollectionDetailsWidgetState extends State<CollectionDetailsWidget>
    with
        SingleTickerProviderStateMixin,
        AutomaticKeepAliveClientMixin<CollectionDetailsWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final isDark = Provider.of<DarkthemeProvider>(context).darktheme;
    final imageQuality =
        Provider.of<ImagequalityProvider>(context).imageQuality;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              Expanded(
                child: Stack(
                  children: <Widget>[
                    widget.belongsToCollection!.backdropPath == null
                        ? Image.asset(
                            'assets/images/na_logo.png',
                            fit: BoxFit.cover,
                          )
                        : CachedNetworkImage(
                            width: double.infinity,
                            height: double.infinity,
                            fadeOutDuration: const Duration(milliseconds: 300),
                            fadeOutCurve: Curves.easeOut,
                            fadeInDuration: const Duration(milliseconds: 700),
                            fadeInCurve: Curves.easeIn,
                            imageUrl:
                                '${TMDB_BASE_IMAGE_URL}original/${widget.belongsToCollection!.backdropPath!}',
                            imageBuilder: (context, imageProvider) => Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: imageProvider,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            placeholder: (context, url) => Image.asset(
                              'assets/images/loading_5.gif',
                              fit: BoxFit.cover,
                            ),
                            errorWidget: (context, url, error) => Image.asset(
                              'assets/images/na_logo.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          gradient: LinearGradient(
                              begin: FractionalOffset.bottomCenter,
                              end: FractionalOffset.topCenter,
                              colors: [
                                const Color(0xFFECB718),
                                const Color(0xFFECB718).withOpacity(0.3),
                                const Color(0xFFECB718).withOpacity(0.2),
                                const Color(0xFFECB718).withOpacity(0.1),
                              ],
                              stops: const [
                                0.0,
                                0.25,
                                0.5,
                                0.75
                              ])),
                    )
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  color: const Color(0xFFECB718),
                ),
              )
            ],
          ),
          Column(
            children: <Widget>[
              AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                leading: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50.0),
                        color: isDark ? Colors.black38 : Colors.white38),
                    child: IconButton(
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Color(0xFFECB718),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ),
                actions: const [],
              ),
              Expanded(
                child: Container(
                  color: Colors.transparent,
                  child: Stack(
                    children: <Widget>[
                      SizedBox(
                        width: double.infinity,
                        height: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(16, 75, 16, 16),
                          child: Card(
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            color: isDark
                                ? const Color(0xFF202124)
                                : const Color(0xFFFFFFFF),
                            child: Column(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(left: 120.0),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          widget.belongsToCollection!.name!,
                                          style: kTextSmallHeaderStyle,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                      top: 50.0,
                                      bottom: 8.0,
                                      right: 8.0,
                                      left: 8.0,
                                    ),
                                    child: SingleChildScrollView(
                                      physics: const BouncingScrollPhysics(),
                                      child: Column(
                                        children: <Widget>[
                                          Row(
                                            children: const <Widget>[
                                              Padding(
                                                padding:
                                                    EdgeInsets.only(left: 8.0),
                                                child: Text(
                                                  'Overview',
                                                  style: kTextHeaderStyle,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: CollectionOverviewWidget(
                                              api: Endpoints
                                                  .getCollectionDetails(widget
                                                      .belongsToCollection!
                                                      .id!),
                                            ),
                                            // child: CollectionOverviewWidget(),
                                          ),
                                          PartsList(
                                            title: 'Movies',
                                            api: Endpoints.getCollectionDetails(
                                                widget
                                                    .belongsToCollection!.id!),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 0,
                        left: 40,
                        child: SizedBox(
                          width: 100,
                          height: 150,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: widget.belongsToCollection!.posterPath ==
                                    null
                                ? Image.asset(
                                    'assets/images/na_logo.png',
                                    fit: BoxFit.cover,
                                  )
                                : CachedNetworkImage(
                                    fadeOutDuration:
                                        const Duration(milliseconds: 300),
                                    fadeOutCurve: Curves.easeOut,
                                    fadeInDuration:
                                        const Duration(milliseconds: 700),
                                    fadeInCurve: Curves.easeIn,
                                    imageUrl: TMDB_BASE_IMAGE_URL +
                                        imageQuality +
                                        widget.belongsToCollection!.posterPath!,
                                    imageBuilder: (context, imageProvider) =>
                                        Container(
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: imageProvider,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    placeholder: (context, url) => Image.asset(
                                      'assets/images/loading.gif',
                                      fit: BoxFit.cover,
                                    ),
                                    errorWidget: (context, url, error) =>
                                        Image.asset(
                                      'assets/images/na_logo.png',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
