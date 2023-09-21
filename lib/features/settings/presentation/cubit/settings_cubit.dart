import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit() : super(SettingsState.initial());
  void changeUnit(WeatherUnit newUnit) {
    emit(state.copyWith(unit: newUnit));
  }

  void updateTheme({required bool isDarkMode}) {
    emit(state.copyWith(isDarkMode: isDarkMode));
  }
}
