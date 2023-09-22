import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weather/di/injection_container.dart';
import 'package:weather/features/weather/data/models/weather_response.dart';
import 'package:weather/features/weather/domain/weather_repo.dart';
import 'package:weather/features/weather/presentation/bloc/weather_bloc.dart';

class MockWeatherRepo extends Mock implements WeatherRepo {}

class MockWeatherBloc extends MockBloc<WeatherEvent, WeatherState>
    implements WeatherBloc {}

void main() {
  late WeatherRepo repo;

  group('GetCurrentWeather', () {
    WeatherResponse response = WeatherResponse.fromJson(const {
      "location": {
        "name": "Piravam",
        "region": "Kerala",
        "country": "India",
        "lat": 9.8,
        "lon": 76.48,
        "tz_id": "Asia/Kolkata",
        "localtime_epoch": 1695204120,
        "localtime": "2023-09-20 15:32"
      },
      "current": {
        "last_updated_epoch": 1695204000,
        "last_updated": "2023-09-20 15:30",
        "temp_c": 32,
        "temp_f": 89.6,
        "is_day": 1,
        "condition": {
          "text": "Partly cloudy",
          "icon": "//cdn.weatherapi.com/weather/64x64/day/116.png",
          "code": 1003
        },
        "wind_mph": 11.9,
        "wind_kph": 19.1,
        "wind_degree": 290,
        "wind_dir": "WNW",
        "pressure_mb": 1008,
        "pressure_in": 29.77,
        "precip_mm": 0.02,
        "precip_in": 0,
        "humidity": 67,
        "cloud": 50,
        "feelslike_c": 41.4,
        "feelslike_f": 106.5,
        "vis_km": 6,
        "vis_miles": 3,
        "uv": 6,
        "gust_mph": 9.1,
        "gust_kph": 14.6
      }
    });
    setUp(() {
      setupInjection();
      repo = MockWeatherRepo();
    });
    blocTest<WeatherBloc, WeatherState>(
      'emits [MyState] '
      'when [GetCurrentWeather] is added.',
      setUp: () {
        when(
          () {
            return repo.getCurrentWeather(
              latitude: 0.0,
              longitude: 0.0,
              apiKey: 'xxx',
            );
          },
        ).thenAnswer((invocation) async {
          return Right(response);
        });
      },
      build: () => WeatherBloc(
        repo: repo,
        key: 'xxx',
      ),
      act: (bloc) => bloc.add(const GetCurrentWeather(
        latitude: 0.0,
        longitude: 0.0,
        isFromCity: false,
      )),
      verify: (bloc) {
        verify(
          () => repo.getCurrentWeather(
            latitude: 0.0,
            longitude: 0.0,
            apiKey: 'xxx',
          ),
        ).called(1);
      },
      expect: () => <WeatherState>[
        WeatherState.initial().copyWith(
          status: Status.loading,
        ),
        WeatherState.initial().copyWith(
          status: Status.loaded,
          weather: response,
          city: ', ',
        ),
      ],
    );
  });
}
