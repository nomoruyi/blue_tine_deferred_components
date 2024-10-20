import 'package:blue_tine_deferred_components/app/cubits/routine/routine_cubit.dart';
import 'package:blue_tine_deferred_components/plugins/get_up/ui/get_up_view.dart' deferred as get_up_view;
import 'package:flutter/material.dart';

class GetUpRoutineCubit extends RoutineCubit {
  GetUpRoutineCubit(super.plugin);

  @override
  Future<Widget> loadPluginView() async {
    await get_up_view.loadLibrary();
    return get_up_view.GetUpView(plugin);
  }
}
