import 'package:blue_tine_deferred_components/interfaces/data/i_plugin_routine.dart';
import 'package:blue_tine_deferred_components/interfaces/data/i_plugin_routine_data.dart';
import 'package:blue_tine_deferred_components/interfaces/data/i_plugin_routine_step.dart';
import 'package:blue_tine_deferred_components/interfaces/data/i_plugin_routine_step_data.dart';
import 'package:blue_tine_deferred_components/plugins/get_up/data/get_up_routine.dart';
import 'package:blue_tine_deferred_components/plugins/get_up/data/get_up_routine_data.dart';
import 'package:blue_tine_deferred_components/plugins/get_up/data/get_up_routine_step.dart';
import 'package:blue_tine_deferred_components/plugins/get_up/data/get_up_routine_step_data.dart';
import 'package:blue_tine_deferred_components/plugins/get_up/controller/get_up_routine_cubit.dart';
import 'package:blue_tine_deferred_components/plugins/plugin.enum.dart';
import 'package:blue_tine_deferred_components/plugins/plugin_manager.dart';
import 'package:blue_tine_deferred_components/utils/hive_util.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';

abstract class GetUpP {
  static Future<void> register() async {
    PluginManager.pluginBox.put(PluginEnum.getUp.name, false);

    PluginManager.plugins[GetUpP] = GetUpController(PluginEnum.getUp);
  }

  static Future<void> install() async {
    await _initHive();
  }
  static Future<void> uninstall() async {
    await _deleteHive();
  }

  static Future<void> _initHive() async {

    Hive
      ..registerAdapter(GetUpRoutineAdapter(), override: true)
      ..registerAdapter(GetUpRoutineStepAdapter(), override: true)
      ..registerAdapter(GetUpRoutineDataAdapter(),override: true)
      ..registerAdapter(GetUpRoutineStepDataAdapter(),override: true);

    await Hive.openBox<IPluginRoutine>(HiveName.routine.plugin(PluginEnum.getUp));
    await Hive.openBox<IPluginRoutineStep>(HiveName.step.plugin(PluginEnum.getUp));

    await Hive.openBox<IPluginRoutineData>(HiveName.routineData.plugin(PluginEnum.getUp));
    await Hive.openBox<IPluginRoutineStepData>(HiveName.stepData.plugin(PluginEnum.getUp));

    _setTestData();

    PluginManager.pluginBox.put(PluginEnum.getUp.name, true);
  }

 static Future<void> _deleteHive() async {
    Hive.deleteBoxFromDisk(HiveName.routine.plugin(PluginEnum.getUp));
    Hive.deleteBoxFromDisk(HiveName.step.plugin(PluginEnum.getUp));

    Hive.deleteBoxFromDisk(HiveName.routineData.plugin(PluginEnum.getUp));
    Hive.deleteBoxFromDisk(HiveName.stepData.plugin(PluginEnum.getUp));

    PluginManager.pluginBox.put(PluginEnum.getUp.name, false);
  }

  static void _setTestData() {
    final Box<IPluginRoutineData> box = Hive.box<IPluginRoutineData>(HiveName.routineData.plugin(PluginEnum.getUp));

    for (int i = 7; i <= 14; i++) {
      final GetUpRoutineData routineData = GetUpRoutineData(getUpRoutine)..test(day: i);

      box.put(DateFormat.yMd().format(routineData.startTime), GetUpRoutineData(getUpRoutine)..test(day: i));
    }
  }

  static final GetUpRoutine getUpRoutine = GetUpRoutine(
    'Waking up',
    'Get out of bead and start your day',
    startTime: const TimeOfDay(hour: 6, minute: 0),
    steps: [
      GetUpRoutineStep(
        'Stretching',
        'To stretch',
        duration: const Duration(minutes: 5),
      ),
      GetUpRoutineStep(
        'Brushing Teeth',
        'To brush teeth',
        duration: const Duration(minutes:2),
      ),
      GetUpRoutineStep(
        'Getting Dressed',
        'To get dressed',
        duration: const Duration(minutes: 3),
      )
    ],
  );
}
