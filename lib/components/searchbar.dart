import 'package:flutter/material.dart';
import 'package:weather_app/constants/textstyles.dart';
import 'package:weather_app/services/weather_api.dart';

import '../services/weather_model.dart';

class AppSearchBar extends StatefulWidget {
  final Function(WeatherModel) onWeatherFetched;
  const AppSearchBar({
    super.key,
    required this.onWeatherFetched,
  });

  @override
  State<AppSearchBar> createState() => _AppSearchBarState();
}

class _AppSearchBarState extends State<AppSearchBar> {
  final TextEditingController textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 100, left: 20, right: 20),
      child: TextField(
        onSubmitted: (query) {
         if (query.isNotEmpty) {
            WeatherApi.fetchData(query).then((model) {
              widget.onWeatherFetched(model); // Call the callback function
              print(model.name);
            }).catchError((error) {
              print('Error: $error');
            });
          }
         },
        controller: textController,
        style: AppTextStyles.labelLarge.copyWith(color: Colors.white),
        textInputAction: TextInputAction.search,
        decoration: InputDecoration(
            suffixIcon: const Icon(
              Icons.search,
              color: Colors.white,
              weight: 10,
              size: 28,
            ),
            hintStyle: AppTextStyles.labelLarge.copyWith(color: Colors.white),
            hintText: 'Search'.toUpperCase(),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.white)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.white)),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.white))),
      ),
    );
  }
}
