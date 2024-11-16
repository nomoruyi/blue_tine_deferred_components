import 'package:blue_tine_deferred_components/interfaces/data/i_plugin_routine_data.dart';
import 'package:blue_tine_deferred_components/plugins/plugin.enum.dart';
import 'package:blue_tine_deferred_components/utils/hive_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';

abstract class PluginController  {
  PluginController(this.plugin) ;

  final PluginEnum plugin;

  bool get isEnabled => Hive.box(HiveName.plugin.name).get(PluginEnum.getUp.name);

  Future<void> install();

  Future<void> uninstall() ;

  Future<Widget> loadPluginView();

  Box<IPluginRoutineData> get routineBox => Hive.box<IPluginRoutineData>(HiveName.routineData.plugin(plugin));

  List<IPluginRoutineData> get routines => routineBox.values.toList()..sort((a, b) => b.startTime.compareTo(a.startTime));

  Future<void> saveRoutine(IPluginRoutineData routineData) async => await routineBox.put(DateFormat.yMd().format(routineData.startTime), routineData);


  int getCurrentStreak() {
    if (routineBox.isEmpty) return 0;

    List<DateTime> startTimes = _getSortedDates();

    int currentStreak = 1;

    for (int i = startTimes.length - 1; i > 0; i--) {
      if (startTimes[i].difference(startTimes[i - 1]).inDays == 1) {
        currentStreak++;
      } else if (startTimes[i].difference(startTimes[i - 1]).inDays > 1) {
        break;
      }
    }

    return currentStreak;
  }

  int getMaxStreak() {
    if (routineBox.isEmpty) return 0;

    List<DateTime> startTimes = _getSortedDates();

    int maxStreak = 1;
    int currentStreak = 1;

    for (int i = 1; i < startTimes.length; i++) {
      if (startTimes[i].difference(startTimes[i - 1]).inDays == 1) {
        currentStreak++;
      } else if (startTimes[i].difference(startTimes[i - 1]).inDays > 1) {
        currentStreak = 1;
      }

      if (currentStreak > maxStreak) {
        maxStreak = currentStreak;
      }
    }

    return maxStreak;
  }

  int getTotalExecutions() => routineBox.values.length;

  double getAvgRating() => routineBox.values.map((r) => r.rating).reduce((a, b) => a + b) / getTotalExecutions();

  _getSortedDates() => routineBox.values.map((data) => data.startTime).toList()..sort();
}
