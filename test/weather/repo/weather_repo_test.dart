import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weather/core/models/app_error.dart';
import 'package:weather/core/networking/rest_service.dart';
import 'package:weather/features/weather/data/models/weather_response.dart';
import 'package:weather/features/weather/data/weather_repo_impl.dart';

class MockRestService extends Mock implements RestService {}

void main() {
  group('WeatherRepoImpl', () {
    late WeatherRepoImpl weatherRepo;
    late MockRestService mockRestService;

    setUp(() {
      mockRestService = MockRestService();
      weatherRepo = WeatherRepoImpl(restService: mockRestService);
    });

    final mockResponse = {
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
    };

    test('getCurrentWeather returns weather', () async {
      // Arrange
      when(() {
        return mockRestService.getDataFromServer(
            url: '/current.json?q=1.0,2.0&key=xxx', header: {});
      }).thenAnswer((_) async {
        return ApiResponse(isError: false, data: mockResponse);
      });

      verifyNever(() => mockRestService.getDataFromServer(
          url: '/current.json?q=1.0,2.0&key=xxx', header: {}));
      // Act
      final result = await weatherRepo.getCurrentWeather(
        latitude: 1.0,
        longitude: 2.0,
        apiKey: 'xxx',
      );
      print('Result: $result');

      // Assert
      expect(
        result,
        const TypeMatcher<Right<AppError, WeatherResponse>>(),
      );
    });

    test('getCurrentWeather handles errors', () async {
      // Arrange
      when(
        () => mockRestService.getDataFromServer(
            url: '/current.json?q=1.0,2.0&key=xxx', header: {}),
      ).thenAnswer((_) async => ApiResponse(isError: true, data: {}));

      // Act
      final result = await weatherRepo.getCurrentWeather(
        latitude: 1.0,
        longitude: 2.0,
        apiKey: 'xxx',
      );

      // Assert
      expect(
        result,
        const TypeMatcher<Left<AppError, WeatherResponse>>(),
      );
    });
  });
}
