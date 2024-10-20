import 'package:blue_tine_deferred_components/interfaces/data/i_plugin_routine.dart';
import 'package:blue_tine_deferred_components/interfaces/data/i_plugin_routine_data.dart';
import 'package:blue_tine_deferred_components/interfaces/data/i_plugin_routine_step.dart';
import 'package:blue_tine_deferred_components/interfaces/data/i_plugin_routine_step_data.dart';
import 'package:blue_tine_deferred_components/plugins/get_up/data/get_up_routine.dart';
import 'package:blue_tine_deferred_components/plugins/get_up/data/get_up_routine_data.dart';
import 'package:blue_tine_deferred_components/plugins/get_up/data/get_up_routine_step.dart';
import 'package:blue_tine_deferred_components/plugins/get_up/data/get_up_routine_step_data.dart';
import 'package:blue_tine_deferred_components/plugins/get_up/cubits/get_up_routine_cubit.dart';
import 'package:blue_tine_deferred_components/plugins/plugin.enum.dart';
import 'package:blue_tine_deferred_components/plugins/plugin_manager.dart';
import 'package:blue_tine_deferred_components/utils/hive_util.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';

abstract class GetUpP {
  static bool isRegistered = false;

  static Future<void> register() async {
    // await getUp.loadLibrary();

    PluginManager.plugins[GetUpP] = GetUpController(PluginEnum.getUp);
  }

  static Future<void> enable() async {
    PluginManager.plugins[GetUpP]?.enable();

    await _initHive();
  }

  static Future<void> _initHive() async {
    Hive
      ..registerAdapter(GetUpRoutineAdapter())
      ..registerAdapter(GetUpRoutineStepAdapter())
      ..registerAdapter(GetUpRoutineDataAdapter())
      ..registerAdapter(GetUpRoutineStepDataAdapter());

    await Hive.openBox<IPluginRoutine>(HiveName.routine.routeFromPlugin(PluginEnum.getUp));
    await Hive.openBox<IPluginRoutineStep>(HiveName.step.routeFromPlugin(PluginEnum.getUp));

    await Hive.openBox<IPluginRoutineData>(HiveName.routineData.routeFromPlugin(PluginEnum.getUp));
    await Hive.openBox<IPluginRoutineStepData>(HiveName.stepData.routeFromPlugin(PluginEnum.getUp));

    _setTestData();

    isRegistered = true;
  }

  static void _setTestData() {
    final Box<IPluginRoutineData> box = Hive.box<IPluginRoutineData>(HiveName.routineData.routeFromPlugin(PluginEnum.getUp));

    for (int i = 7; i <= 14; i++) {
      final GetUpRoutineData routineData = GetUpRoutineData(getUpRoutine)..test(day: i);

      box.put(DateFormat.yMd().format(routineData.startTime), GetUpRoutineData(getUpRoutine)..test(day: i));
    }
  }

  static final GetUpRoutine getUpRoutine = GetUpRoutine(
    'Waking up',
    'Get out of bead and start your day',
    startTime: const TimeOfDay(hour: 6, minute: 1),
    steps: [
      GetUpRoutineStep(
        'Stretching',
        'To stretch',
        duration: const Duration(minutes: 2),
      ),
      GetUpRoutineStep(
        'Brushing Teeth',
        'To brush teeth',
        duration: const Duration(minutes: 3),
      ),
      GetUpRoutineStep(
        'Getting Dressed',
        'To get dressed',
        duration: const Duration(minutes: 4),
      )
    ],
  );
}
