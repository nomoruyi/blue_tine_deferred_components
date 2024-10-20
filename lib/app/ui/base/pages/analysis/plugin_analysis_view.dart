import 'package:blue_tine_deferred_components/app/cubits/routine/routine_cubit.dart';
import 'package:blue_tine_deferred_components/app/data/calendar/i_plugin_routine_calendar_entry.dart';
import 'package:blue_tine_deferred_components/app/ui/widgets/blue_analysis.dart';
import 'package:blue_tine_deferred_components/plugins/plugin.enum.dart';
import 'package:blue_tine_deferred_components/plugins/plugin_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class PluginAnalysisView<T> extends StatefulWidget {
  const PluginAnalysisView(this.plugin, {super.key});

  static create<T>(PluginEnum plugin) => PluginAnalysisView<T>(plugin);

  final PluginEnum plugin;

  @override
  PluginAnalysisViewState createState() => PluginAnalysisViewState();
}

class PluginAnalysisViewState<T> extends State<PluginAnalysisView> {
//TODO: Use Plugin Manager
  late final PluginController _routineCubit = PluginManager.plugins[T]!;

  final List<Appointment> _calendarAppointments = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _calendarAppointments.addAll(_routineCubit.routines.map((r) => IPluginRoutineCalendarEntry.fromRoutineData(r)));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Headline(_routineCubit),
            Calendar(_routineCubit, calendarEntries: _calendarAppointments),
            ToDo(_routineCubit),
            LastExecs(_routineCubit),
          ],
        ),
      )

      /*      child: ListView.separated(
        itemCount: _widgets.length,
        itemBuilder: (context, index) {
          return _widgets[index];
        },
        separatorBuilder: (context, index) {
          return const Divider(height: 16.0, thickness: 0, color: Colors.transparent);
        },
      )*/
      ,
    );
  }
}
