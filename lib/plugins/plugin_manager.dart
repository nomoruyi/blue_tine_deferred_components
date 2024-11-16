import 'package:blue_tine_deferred_components/interfaces/controller/plugin_controller.dart';
import 'package:blue_tine_deferred_components/plugins/get_up/get_up_main.dart';
import 'package:blue_tine_deferred_components/utils/hive_util.dart';
import 'package:hive_flutter/hive_flutter.dart';

class PluginManager {
  static Map<Type, PluginController> plugins = {};

  static Box get pluginBox => Hive.box(HiveName.plugin.name);

  /// Hier werden müssen sämtliche Plugins, die es für die App gibt, registriert werden
  static Future<void> init() async {
   await GetUpP.register();
  }
}
