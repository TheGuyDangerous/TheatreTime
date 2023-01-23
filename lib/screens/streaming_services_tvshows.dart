// ignore_for_file: avoid_unnecessary_containers

import 'package:TheatreTime/provider/adultmode_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/api/endpoints.dart';
import '/screens/tv_widgets.dart';

class StreamingServicesTVShows extends StatelessWidget {
  final int providerId;
  final String providerName;
  const StreamingServicesTVShows(
      {Key? key, required this.providerId, required this.providerName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'TV shows from $providerName',
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
        child: ParticularStreamingServiceTVShows(
          includeAdult: Provider.of<AdultmodeProvider>(context).isAdult,
          providerID: providerId,
          api: Endpoints.watchProvidersTVShows(providerId, 1),
        ),
      ),
    );
  }
}
