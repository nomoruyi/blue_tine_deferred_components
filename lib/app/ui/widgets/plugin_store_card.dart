import 'package:blue_tine_deferred_components/interfaces/controller/plugin_controller.dart';
import 'package:blue_tine_deferred_components/interfaces/ui/i_plugin_stateful_widget.dart';
import 'package:flutter/material.dart';

class PluginStoreCard extends StatefulWidget {
  const PluginStoreCard( this.pluginController, {super.key});

  final PluginController pluginController;

  @override
  State<PluginStoreCard> createState() => _PluginStoreCardState();
}

class _PluginStoreCardState extends State<PluginStoreCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: widget.pluginController.isEnabled ? const Icon(Icons.download_done_rounded) : const Icon(Icons.download_rounded),
        title: Text(widget.pluginController.plugin.name),
        subtitle: const Text('plugin.description'),
        onTap: () => _openDialog(context),
      ),
    );
  }

  void _openDialog(BuildContext context) {
    void install() {
      setState(() {
        widget.pluginController.install();
      });

      Future.delayed(Duration(milliseconds: 500)).then((_) {
        Navigator.of(context).pop();
      });
    }

    void uninstall() {
      setState(() {
        widget.pluginController.uninstall();
      });
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
                  widget.pluginController.isEnabled
                      ? ElevatedButton(
                          onPressed: () => uninstall(),
                          child: const Text('Deinstallieren'),
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.red.shade500))
                      : ElevatedButton(
                          onPressed: () => install(),
                          child: const Text('Installieren'),
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.green.shade500),
                        )
                ],
              )
            ],
          );
        });
  }
}
