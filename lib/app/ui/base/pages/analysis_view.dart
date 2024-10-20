
import 'package:blue_tine_deferred_components/app/cubits/routine/routine_cubit.dart';
import 'package:blue_tine_deferred_components/app/ui/base/pages/analysis/plugin_analysis_view.dart';
import 'package:blue_tine_deferred_components/app/ui/base/pages/analysis/summery_view.dart';
import 'package:blue_tine_deferred_components/app/ui/base/pages/i_base_page.dart';
import 'package:blue_tine_deferred_components/plugins/plugin.enum.dart';
import 'package:blue_tine_deferred_components/plugins/plugin_manager.dart';
import 'package:flutter/material.dart';
import 'package:type_plus/type_plus.dart';

class AnalysisView extends IBasePage {
  const AnalysisView(super.pageController, {super.key});

  @override
  State<AnalysisView> createState() => _AnalysisViewState();
}

class _AnalysisViewState extends State<AnalysisView> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

/*    for(MapEntry<Type, RoutineCubit> entry in PluginManager.plugins.entries) {
      Type t = entry.key;

      final PluginAnalysisView view = PluginAnalysisView(entry.value.plugin).callWith(typeArguments: [t]);

      PluginManager.registerRoutes.callWith()

    }*/
  }
  @override
  Widget build(BuildContext context) {

    return DefaultTabController(
      length: PluginManager.plugins.length + 1,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Analysis', style: Theme.of(context).textTheme.headlineLarge?.copyWith(fontWeight: FontWeight.w900)),
          bottom: TabBar(
            splashFactory: NoSplash.splashFactory,
            physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
            isScrollable: true,
            tabAlignment: TabAlignment.center,
            indicatorColor: Colors.transparent,
            indicator: BoxDecoration(
              color: Theme.of(context).colorScheme.secondaryContainer,

              borderRadius: BorderRadius.circular(24.0)
            ),
            tabs: [
              Tab(child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text('Summery', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w900)),
              )),
              Tab(child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(PluginEnum.getUp.name.toUpperCase(), style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w900)),
              )),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            SummeryView(widget.pageController),
            // TODO: Mega umständlich
            ...PluginManager.plugins.entries.map((MapEntry<Type, RoutineCubit> p) => PluginAnalysisView.create.callWith(parameters: [p.value.plugin],typeArguments: [p.key])),
          ],
        ),
      ),
    );
  }
}
