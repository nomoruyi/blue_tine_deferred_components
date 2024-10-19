import 'dart:math';

import 'package:blue_tine_deferred_components/app/cubits/routine/routine_cubit.dart';

class PluginManager {
  static Map<Type, RoutineCubit> plugins = {};


  static Future<void> init() async {
    // plugins[Plugin.dummy] = initDummy;

  }
}
