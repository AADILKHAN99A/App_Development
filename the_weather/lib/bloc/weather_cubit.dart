import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:meta/meta.dart';
import 'package:weather/weather.dart';

import '../utils/constants/api_constants.dart';

part 'weather_state.dart';

class WeatherCubit extends Cubit<WeatherState> {
  final Position position;

  WeatherCubit({required this.position}) : super(WeatherLoading()) {
    fetchWeatherData();
  }

  fetchWeatherData() async {
    emit(WeatherLoading());
    try {
      WeatherFactory wF = WeatherFactory(ApiConstants.cSecretAPIKey);
      Weather weather = await wF.currentWeatherByLocation(
          position.latitude, position.longitude);
      emitWeatherSuccess(weather);
    } catch (e) {
      emitWeatherFailure();
    }
  }

  emitWeatherSuccess(Weather weather) => emit(WeatherSuccess(weather));

  emitWeatherFailure() => emit(WeatherFailure());
}
