import 'package:blue_tine_deferred_components/app/cubits/routine/routine_cubit.dart';
import 'package:blue_tine_deferred_components/plugins/get_up/get_up_main.dart';

class PluginManager {
  static Map<Type, PluginController> plugins = {};


  static Future<void> init() async {
    // plugins[Plugin.dummy] = initDummy;
    GetUpP.register();

  }
}
