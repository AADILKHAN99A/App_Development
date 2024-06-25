import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_weather/bloc/weather_cubit.dart';
import 'package:the_weather/common/widgets/dual_toned_blur_widget.dart';
import 'package:the_weather/screens/home/widgets/header.dart';
import 'package:the_weather/screens/splash/splash_screen.dart';
import 'package:the_weather/utils/constants/color.dart';
import 'package:the_weather/utils/constants/enums.dart';
import 'package:the_weather/utils/constants/image_strings.dart';
import 'package:the_weather/utils/constants/sizes.dart';
import 'package:the_weather/utils/constants/texts.dart';
import 'package:the_weather/utils/device/device_utility.dart';
import 'package:the_weather/utils/helpers/helper_functions.dart';
import '../../common/widgets/extra_detail_with_icon.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();

    BlocProvider.of<WeatherCubit>(context, listen: false).fetchWeatherData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                BlocProvider.of<WeatherCubit>(context).fetchWeatherData();
              },
              icon: const Icon(Icons.refresh_rounded))
        ],
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(
            40, 1.2 * DeviceUtils.getAppBarHeight(), 40, 20),
        child: SizedBox(
          height: HelperFunctions.screenHeight(context),
          child: Stack(
            children: [
              const DualTonedBlur(),
              BlocBuilder<WeatherCubit, WeatherState>(
                builder: (context, state) {
                  if (state is WeatherSuccess) {
                    return SizedBox(
                      height: HelperFunctions.screenHeight(context),
                      width: HelperFunctions.screenWidth(context),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          /// Header
                          Header(areaName: state.weather.areaName!),

                          /// Weather Icon, Temperature and weather
                          Image.asset(HelperFunctions.getWeatherIconPath(
                              state.weather.weatherConditionCode!)),
                          Center(
                            child: Text(
                              "${state.weather.temperature!.celsius!.round()}${CTexts.degreeCelsiusSymbol}",
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
                              HelperFunctions.getFormattedDate(
                                  state.weather.date!),
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
                                  image: CImages.sunrise,
                                  title: CTexts.homeSunrise,
                                  subTitle: HelperFunctions.getFormattedDate(
                                      state.weather.sunrise!,
                                      format: '')),
                              ExtraDetailsWithIcon(
                                image: CImages.sunset,
                                title: CTexts.homeSunset,
                                subTitle: HelperFunctions.getFormattedDate(
                                    state.weather.sunset!,
                                    format: ""),
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
                                image: CImages.tempMax,
                                title: CTexts.tempMax,
                                subTitle:
                                    "${state.weather.tempMax!.celsius?.round()} ${CTexts.degreeCelsiusSymbol}",
                              ),
                              ExtraDetailsWithIcon(
                                image: CImages.tempMin,
                                title: CTexts.tempMin,
                                subTitle:
                                    "${state.weather.tempMin!.celsius?.round()} ${CTexts.degreeCelsiusSymbol}",
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  } else if (state is WeatherLoading) {
                    return const SplashScreen(type: SplashType.loading,);
                  } else {
                    return const Center(
                      child: Text("Something Wrong"),
                    );
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
