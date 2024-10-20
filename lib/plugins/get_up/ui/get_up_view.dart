import 'package:blue_tine_deferred_components/app/cubits/routine/routine_cubit.dart';
import 'package:blue_tine_deferred_components/plugins/get_up/data/get_up_routine_data.dart';
import 'package:blue_tine_deferred_components/plugins/get_up/get_up_main.dart';
import 'package:blue_tine_deferred_components/plugins/get_up/data/get_up_data.dart';
import 'package:blue_tine_deferred_components/plugins/get_up/data/get_up_routine.dart';
import 'package:blue_tine_deferred_components/plugins/get_up/ui/get_up_routine_active.dart' deferred as get_up_routine_active;
import 'package:blue_tine_deferred_components/plugins/plugin_manager.dart';
import 'package:blue_tine_deferred_components/utils/_utils.export.dart';
import 'package:blue_tine_deferred_components/interfaces/ui/i_plugin_stateful_widget.dart';
import 'package:blue_tine_deferred_components/plugins/plugin.enum.dart';
import 'package:flutter/material.dart';


class GetUpView extends IPluginStatefulWidget {
  const GetUpView(super.plugin, {super.key});

  @override
  State<GetUpView> createState() => _PluginGetUpState();
}

class _PluginGetUpState extends State<GetUpView> {
  final PluginController routineCubit = PluginManager.plugins[GetUpP]!;
  final GetUpData data = GetUpData(PluginEnum.getUp, description: 'A routine for waking up');

  final GetUpRoutine routine = GetUpP.getUpRoutine;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: ListTile(
          title: Text(data.name),
          subtitle: Text('${data.userData}'),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.separated(
            itemBuilder: (context, index) {
              return Card(
                child: ListTile(
                  onTap: () => print('Push Step'),
                  title: Text(routine.steps[index].name),
                  leading: const Icon(Icons.add),
                  trailing: Text(routine.steps[index].duration.formatDuration()),
                ),
              );
            },
            separatorBuilder: (context, index) => const Divider(height: 8.0),
            itemCount: routine.steps.length),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: IconButton.filled(
        onPressed: () => _startRoutine(),
        icon: const Icon(Icons.play_arrow_rounded, size: 40.0),
      ),
    );
  }

  _startRoutine() {
    get_up_routine_active.loadLibrary().then((_){
      GetUpRoutineData routineData = GetUpRoutineData(routine)..start();

      Navigator.of(context).push(MaterialPageRoute(builder: (context) => get_up_routine_active.GetUpRoutineActive(routineData, stepIndex: 0)));
    });
  }
}
