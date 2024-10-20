import 'package:blue_tine_deferred_components/app/cubits/routine/routine_cubit.dart';
import 'package:blue_tine_deferred_components/interfaces/ui/i_plugin_widget.dart';
import 'package:flutter/material.dart';

class PluginStoreCard extends IPluginStatelessWidget {
  const PluginStoreCard(super.plugin, this.pluginController, {super.key});

  final PluginController pluginController;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(plugin.name),
        subtitle: const Text('plugin.description'),
        onTap: () => _openDialog(context),
      ),
    );
  }

  _openDialog(BuildContext context) {
    enable(){
      pluginController.enable();
      Navigator.of(context).pop();
    }

    disable(){
      pluginController.disable();
      Navigator.of(context).pop();
    }

    showDialog(
        context: context,
        builder: (ctx) {
          return SimpleDialog(
            title: const Text('Was möchten Sie mit dem Plugin tun?'),
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ElevatedButton(onPressed: () => enable(), child: const Text('Herunterladen')),
                  ElevatedButton(onPressed: () => disable(), child: const Text('Deinstallieren')),
                ],
              )
            ],
          );
        });
  }
}
