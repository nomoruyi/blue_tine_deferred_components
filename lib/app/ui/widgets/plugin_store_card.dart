import 'package:blue_tine_deferred_components/interfaces/ui/i_plugin_widget.dart';
import 'package:flutter/material.dart';

class PluginStoreCard extends IPluginStatelessWidget {
  const PluginStoreCard(super.plugin, this.openPlugin, {super.key });

  final Function openPlugin;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(plugin.name),
        subtitle: const Text('plugin.description'),
        onTap: () => openPlugin(),
      ),
    );
  }
}
