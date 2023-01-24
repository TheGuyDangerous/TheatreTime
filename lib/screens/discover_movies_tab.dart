import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../constants/api_constants.dart';
import '../constants/app_constants.dart';
import '../models/choice_chip.dart';
import '../models/dropdown_select.dart';
import '../models/filter_chip.dart';
import 'discover_movie_result.dart';

class DiscoverMoviesTab extends StatefulWidget {
  const DiscoverMoviesTab({Key? key}) : super(key: key);

  @override
  State<DiscoverMoviesTab> createState() => _DiscoverMoviesTabState();
}

class _DiscoverMoviesTabState extends State<DiscoverMoviesTab> {
  SortChoiceChipData sortChoiceChipData = SortChoiceChipData();
  AdultChoiceChipData adultChoiceChipData = AdultChoiceChipData();
  YearDropdownData yearDropdownData = YearDropdownData();
  MovieGenreFilterChipData movieGenreFilterChipData =
      MovieGenreFilterChipData();
  WatchProvidersFilterChipData watchProvidersFilterChipData =
      WatchProvidersFilterChipData();
  int sortValue = 0;
  int adultValue = 1;
  String moviesSort = 'popularity.desc';
  bool includeAdult = false;
  String defaultMovieReleaseYear = '';
  double movieTotalRatingSlider = 1;
  bool enableOptionForSliderMovie = false;
  String joinedIds = '';
  String joinedProviderIds = '';
  final List<String> genreNames = <String>[];
  final List<String> genreIds = <String>[];
  final List<String> providersName = <String>[];
  final List<String> providersId = <String>[];

  void setSliderValue(newValue) {
    setState(() {
      movieTotalRatingSlider = newValue;
    });
  }

  void joinGenreStrings() {
    setState(() {
      joinedIds = genreIds.join(',');
    });
  }

  void joinProviderStrings() {
    setState(() {
      joinedProviderIds = providersId.join(',');
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Sort by',
              style: kTextHeaderStyle,
            ),
            Wrap(
              spacing: 3,
              children: sortChoiceChipData.sortChoiceChip
                  .map((SortChoiceChipWidget choiceChipWidget) => ChoiceChip(
                        selectedColor: Colors.transparent,
                        label: Text(choiceChipWidget.name),
                        selected: sortValue == choiceChipWidget.index,
                        onSelected: (bool selected) {
                          setState(() {
                            sortValue =
                                (selected ? choiceChipWidget.index : null)!;
                            moviesSort = choiceChipWidget.value;
                          });
                        },
                      ))
                  .toList(),
            ),
            const Text(
              'Include explicit results',
              style: kTextHeaderStyle,
            ),
            Wrap(
              spacing: 3,
              children: adultChoiceChipData.adultChoiceChip
                  .map((AdultChoiceChipWidget adultChoiceChipWidget) =>
                      ChoiceChip(
                        selectedColor: const Color(0xFFECB718),
                        label: Text(adultChoiceChipWidget.name),
                        selected: adultValue == adultChoiceChipWidget.index,
                        onSelected: (bool selected) {
                          setState(() {
                            adultValue = (selected
                                ? adultChoiceChipWidget.index
                                : null)!;
                            includeAdult = adultChoiceChipWidget.value;
                          });
                        },
                      ))
                  .toList(),
            ),
            const Text(
              'Release year',
              style: kTextHeaderStyle,
            ),
            DropdownButton<String>(
              items: yearDropdownData.getDropdownItems(),
              onChanged: (value) {
                setState(() {
                  defaultMovieReleaseYear = value!;
                });
              },
              value: defaultMovieReleaseYear,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Total ratings',
                      style: kTextHeaderStyle,
                    ),
                    Checkbox(
                      activeColor: const Color(0xFFECB718),
                      value: enableOptionForSliderMovie,
                      onChanged: (newValue) {
                        setState(() {
                          enableOptionForSliderMovie = newValue!;
                          movieTotalRatingSlider = 0;
                        });
                      },
                    ),
                  ],
                ),
                Slider(
                  value: movieTotalRatingSlider,
                  onChanged: enableOptionForSliderMovie
                      ? (newValue) {
                          setSliderValue(newValue);
                        }
                      : null,
                  min: 0,
                  max: 30000,
                  label: '${movieTotalRatingSlider.toInt()}',
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(30.0, 0.0, 30, 15),
                  child: Text(
                    '${movieTotalRatingSlider.toInt().toString()}: ratings',
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 20),
                  ),
                ),
              ],
            ),
            const Text(
              'With Genres',
              style: kTextHeaderStyle,
            ),
            Wrap(
              spacing: 3,
              children: movieGenreFilterChipData.movieGenreFilterdata
                  .map(
                      (MovieGenreFilterChipWidget movieGenreFilterChipWidget) =>
                          FilterChip(
                            selectedColor: const Color(0xFFECB718),
                            label: Text(movieGenreFilterChipWidget.genreName),
                            selected: genreNames
                                .contains(movieGenreFilterChipWidget.genreName),
                            onSelected: (bool value) {
                              setState(() {
                                if (value) {
                                  genreNames.add(
                                      movieGenreFilterChipWidget.genreName);
                                  genreIds.add(
                                      movieGenreFilterChipWidget.genreValue);
                                  genreIds.join(',');
                                } else {
                                  genreNames.removeWhere((String name) {
                                    return name ==
                                        movieGenreFilterChipWidget.genreName;
                                  });
                                  genreIds.removeWhere((String value) {
                                    return value ==
                                        movieGenreFilterChipWidget.genreValue;
                                  });
                                }
                              });
                            },
                          ))
                  .toList(),
            ),
            const Text(
              'With Sreaming services',
              style: kTextHeaderStyle,
            ),
            Wrap(
              spacing: 3,
              children: watchProvidersFilterChipData.providerFilterData
                  .map((WatchProvidersFilterChipWidget
                          watchProvidersFilterChipWidget) =>
                      FilterChip(
                        selectedColor: const Color(0xFFECB718),
                        label: Text(watchProvidersFilterChipWidget.networkName),
                        selected: providersName.contains(
                            watchProvidersFilterChipWidget.networkName),
                        onSelected: (bool value) {
                          setState(() {
                            if (value) {
                              providersName.add(
                                  watchProvidersFilterChipWidget.networkName);
                              providersId.add(
                                  watchProvidersFilterChipWidget.networkId);
                            } else {
                              providersName.removeWhere((String name) {
                                return name ==
                                    watchProvidersFilterChipWidget.networkName;
                              });
                              providersId.removeWhere((String value) {
                                return value ==
                                    watchProvidersFilterChipWidget.networkId;
                              });
                            }
                          });
                        },
                      ))
                  .toList(),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                  style: ButtonStyle(
                      minimumSize: MaterialStateProperty.all(
                          const Size(double.infinity, 50)),
                      backgroundColor:
                          MaterialStateProperty.all(const Color(0xFFECB718))),
                  onPressed: () {
                    joinGenreStrings();
                    joinProviderStrings();

                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return DiscoverMovieResult(
                          api:
                              '$TMDB_API_BASE_URL/discover/movie?api_key=$TMDB_API_KEY&sort_by=$moviesSort&watch_region=US&include_adult=${includeAdult.toString()}&primary_release_year=$defaultMovieReleaseYear&vote_count.gte=${movieTotalRatingSlider.toInt()}&with_genres=$joinedIds&with_watch_providers=$joinedProviderIds',
                          page: 1,
                          includeAdult: includeAdult);
                    }));
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      Padding(
                        padding: EdgeInsets.only(right: 8.0),
                        child: Text('Discover',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold)),
                      ),
                      Icon(
                        FontAwesomeIcons.wandMagicSparkles,
                        color: Colors.white,
                      )
                    ],
                  )),
            )
          ],
        ),
      ),
    );
  }
}
