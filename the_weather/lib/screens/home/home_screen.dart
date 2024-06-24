import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:the_weather/bloc/weather_bloc.dart';
import 'package:the_weather/common/widgets/dual_toned_blur_widget.dart';
import 'package:the_weather/utils/constants/color.dart';
import 'package:the_weather/utils/constants/sizes.dart';
import 'package:the_weather/utils/device/device_utility.dart';
import 'package:the_weather/utils/helpers/helper_functions.dart';
import '../../common/widgets/extra_detrail_with_icon.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Widget getWeatherIcon(int code) {
    switch (code) {
      case > 200 && <= 300:
        return Image.asset("assets/images/1.png");
      case > 300 && <= 400:
        return Image.asset("assets/images/2.png");
      case > 500 && <= 600:
        return Image.asset("assets/images/3.png");
      case > 600 && <= 700:
        return Image.asset("assets/images/4.png");
      case > 700 && <= 800:
        return Image.asset("assets/images/5.png");
      case 800:
        return Image.asset("assets/images/6.png");
      case > 800 && <= 804:
        return Image.asset("assets/images/7.png");

      default:
        return Image.asset("assets/images/7.png");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        // title: const Text("The Weather"),
        elevation: 0,
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(
            40, 1.2 * DeviceUtils.getAppBarHeight(), 40, 20),
        child: SizedBox(
          height: HelperFunctions.screenHeight(context),
          child: Stack(
            children: [
              const DualTonedBlur(),
              BlocBuilder<WeatherBloc, WeatherBlocState>(
                builder: (context, state) {
                  if (state is WeatherBlocSuccess) {
                    return SizedBox(
                      height: HelperFunctions.screenHeight(context),
                      width: HelperFunctions.screenWidth(context),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          /// Header
                          Text(
                            "📍 ${state.weather.areaName}",
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          const SizedBox(
                            height: CSizes.spaceBtwItems,
                          ),
                          Text(
                            "Good Morning",
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),

                          /// Weather Icon, Temperature and weather
                          getWeatherIcon(state.weather.weatherConditionCode!),
                          Center(
                            child: Text(
                              "${state.weather.temperature!.celsius!.round()}°C",
                              style: Theme.of(context).textTheme.displayLarge,
                            ),
                          ),
                          Center(
                            child: Text(
                              state.weather.weatherDescription
                                  .toString()
                                  .toUpperCase(),
                              style: Theme.of(context).textTheme.displayMedium,
                            ),
                          ),
                          const SizedBox(
                            height: CSizes.xs,
                          ),
                          Center(
                            child: Text(
                              DateFormat('EEEE dd .')
                                  .add_jm()
                                  .format(state.weather.date!),
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ),
                          const SizedBox(
                            height: CSizes.xl,
                          ),

                          // Extra Details
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ExtraDetailsWithIcon(
                                  image: 'assets/images/11.png',
                                  title: "Sunrise",
                                  subTitle: DateFormat()
                                      .add_jm()
                                      .format(state.weather.sunrise!)),
                              ExtraDetailsWithIcon(
                                image: 'assets/images/12.png',
                                title: "Sunset",
                                subTitle: DateFormat()
                                    .add_jm()
                                    .format(state.weather.sunset!),
                              ),
                            ],
                          ),

                          const Padding(
                            padding:
                                EdgeInsets.symmetric(horizontal: CSizes.sm),
                            child: Divider(
                              color: CColors.darkGrey,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ExtraDetailsWithIcon(
                                image: 'assets/images/13.png',
                                title: "Temp Max",
                                subTitle:
                                    "${state.weather.tempMax!.celsius?.round()} °C",
                              ),
                              ExtraDetailsWithIcon(
                                image: 'assets/images/14.png',
                                title: "temp Min",
                                subTitle:
                                    "${state.weather.tempMin!.celsius?.round()} °C",
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  } else {
                    return Container();
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
