import 'package:blue_tine_deferred_components/app/cubits/routine/routine_cubit.dart';
import 'package:blue_tine_deferred_components/app/ui/widgets/plugin_dashboard_card.dart';
import 'package:blue_tine_deferred_components/plugins/plugin_manager.dart';
import 'package:flutter/material.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {


  Future<List<Widget>> getDashboardPlugins() async {
    final List<Widget> pluginWidgets = [];

    for (RoutineCubit cubit in PluginManager.plugins.values) {
      pluginWidgets.add(await cubit.loadPluginView());
    }

    return pluginWidgets;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future:getDashboardPlugins(),
        builder: (context, snapshot) {
          if(snapshot.hasError) {
            return Text('ERROR');
          }
          if(!snapshot.hasData) {
            return Text('LOADING');
          }

          return Scaffold(
            appBar: AppBar(
              title: Text('Dashboard', style: Theme.of(context).textTheme.headlineLarge?.copyWith(fontWeight: FontWeight.w900)),
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
              child: ListView.separated(
                itemCount: PluginManager.plugins.length,
                itemBuilder: (context, index) {
                  Widget widget = snapshot.data![index];

                  return PluginDashboardCard(PluginManager.plugins.values.toList()[index].plugin, widget);
                },
                separatorBuilder: (context, index) {
                  return const Divider(height: 4.0, thickness: 0, color: Colors.transparent);
                },
              ),
            ),
          );
        }
    );
  }
}
