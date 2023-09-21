part of 'settings_cubit.dart';

@immutable
class SettingsState extends Equatable {
  final WeatherUnit unit;
  final String city;
  final bool isDarkMode;

  const SettingsState({
    required this.unit,
    required this.city,
    required this.isDarkMode,
  });

  factory SettingsState.initial() {
    return const SettingsState(
      unit: WeatherUnit.celsius,
      city: '',
      isDarkMode: false,
    );
  }

  SettingsState copyWith({WeatherUnit? unit, String? city, bool? isDarkMode}) {
    return SettingsState(
      unit: unit ?? this.unit,
      city: city ?? this.city,
      isDarkMode: isDarkMode ?? this.isDarkMode,
    );
  }

  @override
  List<Object> get props => [unit, city, isDarkMode];
}

enum WeatherUnit {
  celsius,
  fahrenheit,
}
