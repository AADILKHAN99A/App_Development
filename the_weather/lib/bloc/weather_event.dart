part of 'weather_bloc.dart';

sealed class WeatherEvent extends Equatable {
  const WeatherEvent();

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class FetchWeather extends WeatherEvent {
  final Position position;

  FetchWeather(this.position);

  @override
  // TODO: implement props
  List<Object?> get props => [position];
}
