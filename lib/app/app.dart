import 'package:blue_tine_deferred_components/app/cubits/settings/settings_cubit.dart';
import 'package:blue_tine_deferred_components/plugins/plugin_manager.dart';
import 'package:blue_tine_deferred_components/utils/settings_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlueTineApp extends StatefulWidget {
  const BlueTineApp({super.key});

  @override
  State<BlueTineApp> createState() => _BlueTineAppState();
}

class _BlueTineAppState extends State<BlueTineApp> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => SettingsCubit()),
        ...PluginManager.plugins.values.map((p) => BlocProvider(create: (context) => p))
      ],
      child: BlocBuilder<SettingsCubit, SettingsState>(
        builder: (context, state) {
          final SettingsCubit settings = BlocProvider.of<SettingsCubit>(context);

          WidgetsBinding.instance.platformDispatcher.onPlatformBrightnessChanged = () => setState(() {});

          UISize.selectedUIType = settings.size;

          return Builder(builder: (context) {
            return MaterialApp(
              title: 'BLUEtine',
              darkTheme: darkTheme,
              theme: lightTheme,
              themeMode: settings.theme,
            );
          });
        },
      ),
    );
  }
}
