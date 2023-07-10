
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:weather_app/constants/textstyles.dart';

/* ---------------------------------------------------------------- */
/*                 city serach local implementation                 */
/* ---------------------------------------------------------------- */


class CitySearchLocal extends SearchDelegate<String> {
  
  final cities = ["Delhi", "Mumbai", "Kolkata", "Indore", "Haldwani"];

  final recentCities = ["Delhi", "Mumbai", "Haldwani"];

  /* ---------------------------------------------------------------- */
  /*                         clear suggestion                         */
  /* ---------------------------------------------------------------- */
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const FaIcon(FontAwesomeIcons.xmark),
        onPressed: () {
          if (query.isEmpty) {
            close(context, '');
          } else {
            query = '';
            showSuggestions(context);
          }
        },
      )
    ];
  }

  /* ---------------------------------------------------------------- */
  /*                           close search                           */
  /* ---------------------------------------------------------------- */
  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const FaIcon(FontAwesomeIcons.chevronLeft),
      onPressed: () {
        close(context, '');
      },
    );
  }

  /* ---------------------------------------------------------------- */
  /*                            result page                           */
  /* ---------------------------------------------------------------- */
  @override
  Widget buildResults(BuildContext context) {
    return Container(
        child: Center(
            child: Column(children: [
      Text(
        query,
      )
    ])));
  }

  /* ---------------------------------------------------------------- */
  /*                            suggestions                           */
  /* ---------------------------------------------------------------- */
  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = query.isEmpty
        ? recentCities
        : cities.where((city) {
            final cityLower = city.toLowerCase();
            final queryLower = query.toLowerCase();

            return cityLower.startsWith(queryLower);
          }).toList();
    return buildSuggestionsSuccess(suggestions);
  }

  /* ---------------------------------------------------------------- */
  /*                        correct suggestions                       */
  /* ---------------------------------------------------------------- */
  Widget buildSuggestionsSuccess(List<String> suggestions) {
    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (BuildContext context, int index) {
        final suggestion = suggestions[index];
        final queryText = query.substring(0, query.length);
        final remainingText = suggestion.substring(query.length);
        return ListTile(
          onTap: () {
            query = suggestion;
            //showResults(context);
            close(context, suggestion);
          },
          title: RichText(
              text: TextSpan(
                  text: queryText,
                  style: AppTextStyles.bodyLarge
                      .copyWith(fontWeight: FontWeight.bold),
                  children: [
                TextSpan(text: remainingText, style: AppTextStyles.bodyLarge)
              ])),
        );
      },
    );
  }
}
