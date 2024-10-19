import 'package:blue_tine_deferred_components/interfaces/data/i_plugin_routine_data.dart';
import 'package:blue_tine_deferred_components/plugins/plugin.enum.dart';
import 'package:blue_tine_deferred_components/utils/_utils.export.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';

part 'routine_state.dart';

class RoutineCubit<T> extends Cubit<RoutineState> {

  RoutineCubit(this.plugin) : super(RoutineInitial());/*{
    PluginManager.plugins[T] = this;
  }*/

  final PluginEnum plugin;

  late final Box<IPluginRoutineData> routineBox = Hive.box<IPluginRoutineData>(HiveName.routineData.routeFromPlugin(plugin));

  List<IPluginRoutineData> get routines => routineBox.values.toList()..sort((a, b) => b.startTime.compareTo(a.startTime));

  Future<void> onSaveRoutine(IPluginRoutineData routineData) async {
    emit(SavingRoutine());

    routineBox.put(DateFormat.yMd().format(routineData.startTime), routineData).then((_) => emit(RoutineSaved()));
  }

  int getCurrentStreak() {
    if (routineBox.isEmpty) return 0;

    // Alle startTimes abrufen und nach Datum sortieren
    List<DateTime> startTimes = _getSortedDates();

    int currentStreak = 1;

    for (int i = startTimes.length - 1; i > 0; i--) {
      // Prüfen, ob der aktuelle Tag der vorherigen ist
      if (startTimes[i].difference(startTimes[i - 1]).inDays == 1) {
        currentStreak++;
      } else if (startTimes[i].difference(startTimes[i - 1]).inDays > 1) {
        // Abbruch, wenn die Differenz größer als 1 Tag ist
        break;
      }
    }

    return currentStreak;
  }

  int getMaxStreak() {
    if (routineBox.isEmpty) return 0;

    // Alle startTimes abrufen und nach Datum sortieren
    List<DateTime> startTimes = _getSortedDates();

    int maxStreak = 1;
    int currentStreak = 1;

    for (int i = 1; i < startTimes.length; i++) {
      // Prüfen, ob der aktuelle Tag der vorherigen ist
      if (startTimes[i].difference(startTimes[i - 1]).inDays == 1) {
        currentStreak++;
      } else if (startTimes[i].difference(startTimes[i - 1]).inDays > 1) {
        // Reset des aktuellen Streaks, wenn die Differenz größer als 1 Tag ist
        currentStreak = 1;
      }

      // Maximalen Streak aktualisieren
      if (currentStreak > maxStreak) {
        maxStreak = currentStreak;
      }
    }

    return maxStreak;
  }

  int getTotalExecutions() => routineBox.values.length;

  double getAvgRating() => routineBox.values.map((r) => r.rating).reduce((a, b) => a +b ) / getTotalExecutions();

  _getSortedDates() => routineBox.values.map((data) => data.startTime).toList()..sort();
}
