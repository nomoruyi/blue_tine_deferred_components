import 'package:blue_tine_deferred_components/interfaces/data/i_plugin_routine_step.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'get_up_routine_step.g.dart';

@HiveType(typeId: 24)
class GetUpRoutineStep extends IPluginRoutineStep {
  GetUpRoutineStep(super.name,super.description, { required super.duration});
}
