part of 'settings_cubit.dart';

@immutable
class SettingsState extends Equatable {
  final WeatherUnit unit;
  final bool isDarkMode;

  const SettingsState({
    required this.unit,
    required this.isDarkMode,
  });

  factory SettingsState.initial() {
    return const SettingsState(
      unit: WeatherUnit.celsius,
      isDarkMode: false,
    );
  }

  SettingsState copyWith({WeatherUnit? unit, String? city, bool? isDarkMode}) {
    return SettingsState(
      unit: unit ?? this.unit,
      isDarkMode: isDarkMode ?? this.isDarkMode,
    );
  }

  @override
  List<Object> get props => [unit, isDarkMode];
}

enum WeatherUnit {
  celsius,
  fahrenheit,
}
