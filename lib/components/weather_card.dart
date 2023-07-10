import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/components/searchbar.dart';
import 'package:weather_app/constants/colors.dart';

import 'package:flutter/material.dart';
import 'package:weather_app/constants/textstyles.dart';
import 'package:weather_app/services/weather_model.dart';

class WeatherCard extends StatelessWidget {
  final WeatherModel weatherModel;
  const WeatherCard({
    super.key,
    required this.weatherModel,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: const Alignment(0.0, 1.0),
      child: SizedBox(
        height: 10,
        width: 10,
        child: OverflowBox(
          minWidth: 0.0,
          maxWidth: MediaQuery.of(context).size.width,
          minHeight: 0,
          maxHeight: (MediaQuery.of(context).size.height / 4),
          child: Stack(children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              width: double.infinity,
              height: double.infinity,
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
                      padding:
                          const EdgeInsets.only(top: 15, left: 20, right: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Text(
                              "${weatherModel.name}, ${weatherModel.sys.country}"
                                  .toUpperCase(),
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(left: 50),
                          child: Column(
                            children: [
                              Text(
                                weatherModel.weather[0].description
                                    .toUpperCase(),
                                style: AppTextStyles.labelMedium
                                    .copyWith(color: Colors.black45),
                              ),
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
