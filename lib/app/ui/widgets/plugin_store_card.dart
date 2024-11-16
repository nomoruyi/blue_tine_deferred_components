import 'package:blue_tine_deferred_components/interfaces/controller/plugin_controller.dart';
import 'package:flutter/material.dart';

class PluginStoreCard extends StatefulWidget {
  const PluginStoreCard(this.pluginController, {super.key});

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
    Future<void> install() async {
      setState(() async {
        await widget.pluginController.install();
      });

      Navigator.of(context).pop();
    }

    void uninstall() {
      setState(() async {
        await widget.pluginController.uninstall();
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
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.red.shade500),
                          child: const Text('Deinstallieren'))
                      : ElevatedButton(
                          onPressed: () => install(),
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.green.shade500),
                          child: const Text('Installieren'),
                        )
                ],
              )
            ],
          );
        });
  }
}
