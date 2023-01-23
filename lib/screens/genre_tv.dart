// ignore_for_file: avoid_unnecessary_containers

import 'package:TheatreTime/provider/adultmode_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/api/endpoints.dart';
import '/models/genres.dart';
import '/screens/tv_widgets.dart';

class TVGenre extends StatelessWidget {
  final Genres genres;
  const TVGenre({Key? key, required this.genres}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${genres.genreName!} TV shows',
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        child: ParticularGenreTV(
          includeAdult: Provider.of<AdultmodeProvider>(context).isAdult,
          genreId: genres.genreID!,
          api: Endpoints.getTVShowsForGenre(genres.genreID!, 1),
        ),
      ),
    );
  }
}
