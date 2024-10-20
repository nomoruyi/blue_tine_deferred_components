import 'package:blue_tine_deferred_components/app/app.dart';
import 'package:blue_tine_deferred_components/plugins/plugin_manager.dart';
import 'package:blue_tine_deferred_components/utils/hive_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  await HiveUtil.init();

  await PluginManager.init();

  runApp(const BlueTineApp());
}
