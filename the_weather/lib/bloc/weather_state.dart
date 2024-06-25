part of 'weather_cubit.dart';

@immutable
sealed class WeatherState {}

final class WeatherLoading extends WeatherState {}

final class WeatherSuccess extends WeatherState {
  final Weather weather;

  WeatherSuccess(this.weather);
}

final class WeatherFailure extends WeatherState {}
