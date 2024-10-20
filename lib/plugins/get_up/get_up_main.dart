import 'package:blue_tine_deferred_components/app/cubits/routine/routine_cubit.dart';
import 'package:blue_tine_deferred_components/interfaces/data/i_plugin_routine.dart';
import 'package:blue_tine_deferred_components/interfaces/data/i_plugin_routine_data.dart';
import 'package:blue_tine_deferred_components/interfaces/data/i_plugin_routine_step.dart';
import 'package:blue_tine_deferred_components/interfaces/data/i_plugin_routine_step_data.dart';
import 'package:blue_tine_deferred_components/plugins/get_up/data/get_up_routine.dart';
import 'package:blue_tine_deferred_components/plugins/get_up/data/get_up_routine_data.dart';
import 'package:blue_tine_deferred_components/plugins/get_up/data/get_up_routine_step.dart';
import 'package:blue_tine_deferred_components/plugins/get_up/data/get_up_routine_step_data.dart';
import 'package:blue_tine_deferred_components/plugins/get_up/get_up_routine_cubit.dart';
import 'package:blue_tine_deferred_components/plugins/plugin.enum.dart';
import 'package:blue_tine_deferred_components/plugins/plugin_manager.dart';
import 'package:blue_tine_deferred_components/utils/hive_util.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';

import 'package:blue_tine_deferred_components/plugins/get_up/ui/get_up_routine_active.dart' deferred as plugin_routine_active;
import 'package:blue_tine_deferred_components/plugins/get_up/ui/get_up_routine_finished.dart' deferred as plugin_routine_finished;
import 'package:blue_tine_deferred_components/plugins/get_up/ui/get_up_step.dart' deferred as plugin_step;
import 'package:blue_tine_deferred_components/plugins/get_up/ui/get_up_view.dart' deferred as plugin_view;



abstract class GetUpP{
  static bool isRegistered = false;

  static  Future<void> register() async {
    // await getUp.loadLibrary();

    PluginManager.plugins[GetUpP] = GetUpRoutineCubit(PluginEnum.getUp, /*loadLibrary: plugin_view, widget: plugin_view.GetUpView(PluginEnum.getUp)*/);
    await _initHive();
  }

  static Future<void> deregister()async{

  }

  static Future<void> _initHive()async {
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

    for(int i = 7; i <=14; i++) {
      final GetUpRoutineData routineData = GetUpRoutineData(getUpRoutine)..test(day: i);

      box.put(DateFormat.yMd().format(routineData.startTime),GetUpRoutineData(getUpRoutine)..test(day: i));
    }
  }

  static final GetUpRoutine getUpRoutine = GetUpRoutine(
    'Waking up',
    'More waking up',
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
