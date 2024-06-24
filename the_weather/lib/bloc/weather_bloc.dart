import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:the_weather/utils/constants/api_constants.dart';
import 'package:weather/weather.dart';

part 'weather_event.dart';

part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherBlocState> {
  WeatherBloc() : super(WeatherBlocInitial()) {
    on<FetchWeather>((event, emit) async {
      emit(WeatherBlocLoading());
      try {
        WeatherFactory wF = WeatherFactory(ApiConstants.cSecretAPIKey,
            language: Language.ENGLISH);

        Weather weather = await wF.currentWeatherByLocation(
            event.position.latitude, event.position.longitude);
        print(weather);

        emit(WeatherBlocSuccess(weather));
      } catch (e) {
        emit(WeatherBlocFailure());
      }
    });
  }
}
