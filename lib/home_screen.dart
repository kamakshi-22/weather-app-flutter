import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/components/searchbar.dart';
import 'package:weather_app/components/weather_card.dart';
import 'package:weather_app/constants/colors.dart';
import 'package:weather_app/constants/textstyles.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController textController = TextEditingController();
  var weatherData;
  Future<void> fetchData(String? query) async {
    query ??= "New York";
    const apiKey = '1cdc594fa598910075ee4abec85549eb';
    String apiUrl =
        'https://api.openweathermap.org/data/2.5/weather?q=$query&appid=$apiKey';
    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          weatherData = data;
        });
        print("data: $data");
        print("name: ${data['name']}");
        print("country: ${data['sys']['country']}");
        print("description: ${data['weather'][0]['description']}");
        print("wind: ${data["wind"]["speed"]} m/s");
        print(
            "Temperature: ${(data['main']['temp'] - 273.15).toStringAsFixed(1)}°C");
        print(
            "Min: ${(data['main']['temp_min'] - 273.15).toStringAsFixed(1)}°C");
        print(
            "Min: ${(data['main']['temp_max'] - 273.15).toStringAsFixed(1)}°C");
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.red,
            content: Text('No city found. Please try again.'),
          ),
        );
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData("New York");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/sky.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(children: [
        Column(
          children: [
            Expanded(
              flex: 1,
              /* Background Image */
              child: Column(
                children: <Widget>[
                  /* Menu button */
                  AppBar(
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    leading: IconButton(
                      onPressed: () {},
                      icon: const FaIcon(
                        FontAwesomeIcons.bars,
                      ),
                    ),
                  ),
                  /* Search Bar */
                  Container(
                    padding:
                        const EdgeInsets.only(top: 60, left: 20, right: 20),
                    child: TextField(
                      onSubmitted: (query) {
                        if (query.isNotEmpty) {
                          fetchData(query);
                        }
                      },
                      controller: textController,
                      style: AppTextStyles.labelLarge
                          .copyWith(color: Colors.white),
                      textInputAction: TextInputAction.search,
                      decoration: InputDecoration(
                          suffixIcon: const Icon(
                            Icons.search,
                            color: Colors.white,
                            weight: 10,
                            size: 28,
                          ),
                          hintStyle: AppTextStyles.labelLarge
                              .copyWith(color: Colors.white),
                          hintText: 'Search'.toUpperCase(),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:
                                  const BorderSide(color: Colors.white)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:
                                  const BorderSide(color: Colors.white)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:
                                  const BorderSide(color: Colors.white))),
                    ),
                  ),
                  const Gap(50),
                  /* Card */
                  Stack(children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      height: 300,
                      width: double.infinity,
                      child: Card(
                        color: Colors.white,
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            /* Card Header */
                            Container(
                              padding: const EdgeInsets.only(
                                  top: 15, left: 20, right: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Center(
                                    child: Text(
                                      (weatherData != null)
                                          ? "${weatherData['name']}, ${weatherData['sys']['country']}"
                                              .toUpperCase()
                                          : "",
                                      style: AppTextStyles.headlineMedium
                                          .copyWith(color: Colors.black45),
                                    ),
                                  ),
                                  Center(
                                    child: Text(
                                      DateFormat()
                                          .add_MMMMEEEEd()
                                          .format(DateTime.now()),
                                      style: AppTextStyles.bodyMedium
                                          .copyWith(color: Colors.black45),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            const Divider(),
                            /* Card Description*/
                            Text(
                              (weatherData != null)
                                  ? "${weatherData['weather'][0]['description']}"
                                      .toUpperCase()
                                  : "",
                              style: AppTextStyles.labelMedium
                                  .copyWith(color: Colors.black45),
                            ),
                            const Gap(10),
                            Text(
                              (weatherData != null)
                                  ? "${(weatherData['main']['temp'] - 273.15).toStringAsFixed(1)}°C"
                                  : "",
                              style: AppTextStyles.headlineMedium
                                  .copyWith(color: Colors.black45),
                            ),
                            const Gap(10),
                            Text(
                              (weatherData != null)
                                  ? "min: ${(weatherData['main']['temp_min'] - 273.15).toStringAsFixed(1)}°C max: ${(weatherData['main']['temp_max'] - 273.15).toStringAsFixed(1)}°C "
                                  : "",
                              style: AppTextStyles.labelMedium
                                  .copyWith(color: Colors.black45),
                            ),
                            const Gap(10),
                            Text(
                              (weatherData != null)
                                  ? "wind:${weatherData["wind"]["speed"]} m/s "
                                  : "",
                              style: AppTextStyles.labelMedium
                                  .copyWith(color: Colors.black45),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: -50,
                      left: MediaQuery.of(context).size.width / 2,
                      child: Container(
                        height: 150,
                        width: 250,
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(
                                    "https://img.icons8.com/?size=512&id=111603&format=png"))),
                      ),
                    ),
                  ]),
                ],
              ),
            ),
          ],
        ),
      ]),
    ));
  }
}
