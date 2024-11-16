import 'package:blue_tine_deferred_components/utils/hive_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';


part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState>  {
  SettingsCubit() : super(SettingsInitial());

  static final Box settings = Hive.box(HiveName.settings.name);

  //region THEME
  ThemeMode get theme => ThemeMode.values.byName(settings.get(HiveKey.theme.name));

  set theme(ThemeMode newTheme) {
    settings.put(HiveKey.theme.name, newTheme.name);

    emit(ThemeChanged(newTheme.name, useSystemTheme: false));
  }

//endregion

  void reset() {
    settings.put(HiveKey.theme.name, ThemeMode.system.name);

    emit(SettingsResetted());
  }
}
