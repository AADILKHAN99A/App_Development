import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_weather/bloc/weather_cubit.dart';
import 'package:the_weather/screens/home/home_screen.dart';
import 'package:the_weather/screens/splash/splash_screen.dart';
import 'package:the_weather/utils/constants/enums.dart';
import 'package:the_weather/utils/helpers/helper_functions.dart';
import 'package:the_weather/utils/theme/app_theme.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        themeMode: ThemeMode.dark,
        darkTheme: AppTheme.darkThemeData,
        theme: AppTheme.lightThemeData,
        debugShowCheckedModeBanner: false,
        title: 'The Weather',
        home: FutureBuilder(
            future: HelperFunctions.determinePosition(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return BlocProvider<WeatherCubit>(
                  create: (context) => WeatherCubit(position: snapshot.data!),
                  child: const HomeScreen(),
                );
              } else {
                return const SplashScreen(
                  type: SplashType.appLoading,
                );
              }
            }));
  }
}
