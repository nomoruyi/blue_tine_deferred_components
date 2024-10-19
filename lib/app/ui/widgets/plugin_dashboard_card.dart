import 'package:blue_tine_deferred_components/interfaces/ui/i_plugin_widget.dart';
import 'package:blue_tine_deferred_components/plugins/get_up/ui/get_up_view.dart';
import 'package:flutter/material.dart';

class PluginDashboardCard extends IPluginStatelessWidget {
  const PluginDashboardCard(super.plugin, {super.key });

  @override
  Widget build(BuildContext context) {

    return Card(
      child: ListTile(
        title: Text(plugin.name),
        subtitle: const Text('plugin.description'),
        onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => GetUpView(plugin))),
      ),
    );
  }
}
