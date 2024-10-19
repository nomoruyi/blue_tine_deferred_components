import 'package:blue_tine_deferred_components/app/ui/widgets/plugin_dashboard_card.dart';
import 'package:blue_tine_deferred_components/plugins/plugin.enum.dart';
import 'package:flutter/material.dart';

class StoreView extends StatefulWidget {
  const StoreView({super.key});

  @override
  State<StoreView> createState() => _StoreViewState();
}

class _StoreViewState extends State<StoreView> {
  final plugins = [ const PluginDashboardCard(PluginEnum.getUp)];


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Store', style: Theme.of(context).textTheme.headlineLarge?.copyWith(fontWeight: FontWeight.w900)),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
        child: ListView.separated(
          itemCount: plugins.length,
          itemBuilder: (context, index) {
            return plugins[index];
          },
          separatorBuilder: (context, index) {
            return const Divider(height: 4.0, thickness: 0, color: Colors.transparent);
          },
        ),
      ),
    );
  }
}
