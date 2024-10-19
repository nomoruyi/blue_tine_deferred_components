import 'package:blue_tine_deferred_components/interfaces/data/duration.g.dart';
import 'package:blue_tine_deferred_components/interfaces/data/enums/routine_status.dart';
import 'package:blue_tine_deferred_components/interfaces/data/time_of_day.g.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:blue_tine_deferred_components/plugins/plugin.enum.dart';

/// Constant names for all hive boxes
enum HiveName { settings, plugin, routine, step, routineData, stepData }

extension HiveNameExt on HiveName{
  String routeFromPlugin(PluginEnum plugin) {
    return '${plugin.name}_$name';
  }
}

/// Identifier for "singleton-like" values in certain boxes
enum HiveKey { authData, language, size, theme, useSystemTheme, installedPlugins }

abstract class HiveUtil {
  static Future<void> init() async {
    await Hive.initFlutter();

    final Box settings = await Hive.openBox(HiveName.settings.name);

    // First time initializing app settings
    if (settings.isEmpty) {
      // Set to device language if device language is an available language, otherwise sets it to german
      settings.put(HiveKey.theme.name, ThemeMode.system.name);
    }

    // Registering generated Hive adapters
    Hive.registerAdapter(RoutineStatusAdapter());
    Hive.registerAdapter(DurationAdapter());
    Hive.registerAdapter(TimeOfDayAdapter());
    // Initializing needed Hive boxes
  }
}
