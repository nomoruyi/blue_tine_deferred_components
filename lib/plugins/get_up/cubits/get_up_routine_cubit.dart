import 'package:blue_tine_deferred_components/app/cubits/routine/routine_cubit.dart';
import 'package:blue_tine_deferred_components/plugins/get_up/get_up_main.dart';
import 'package:blue_tine_deferred_components/plugins/get_up/ui/get_up_view.dart' deferred as get_up_view;
import 'package:flutter/material.dart';

class GetUpController extends PluginController{
  GetUpController(super.plugin);

  @override
  Future<Widget> loadPluginView() async {
    if (isEnabled) {
      await get_up_view.loadLibrary();
      return get_up_view.GetUpView(plugin);
    }

    throw Exception('Plugin has to be enabled');
  }

  @override
  Future<void> install() async {
   await GetUpP.install();
  }

  @override
  Future<void> uninstall() async {
    await GetUpP.uninstall();
  }


}
