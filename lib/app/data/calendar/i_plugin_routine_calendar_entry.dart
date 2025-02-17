import 'package:blue_tine_deferred_components/interfaces/data/i_plugin_routine_data.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';


class IPluginRoutineCalendarEntry extends Appointment {

  final IPluginRoutineData routineData;

  IPluginRoutineCalendarEntry.fromRoutineData(this.routineData) : super(
    subject: routineData.name,
    startTime: routineData.startTime,
    endTime: routineData.startTime,
  );
}
