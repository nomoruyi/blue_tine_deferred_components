import 'package:blue_tine_deferred_components/app/ui/widgets/_widgets.export.dart';
import 'package:blue_tine_deferred_components/plugins/plugin.enum.dart';
import 'package:flutter/material.dart';

class SummeryView extends StatefulWidget {
  const SummeryView(this.pageController, {super.key});

  final PageController pageController;

  @override
  SummeryViewState createState() => SummeryViewState();
}

class SummeryViewState extends State<SummeryView> {
  late final List<Widget> _widgets = [_maxStreakWidget(), _discoverNewRoutines()];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
        child: ListView.separated(
          itemCount: _widgets.length,
          itemBuilder: (context, index) {
            return _widgets[index];
          },
          separatorBuilder: (context, index) {
            return const Divider(height: 8.0, thickness: 0, color: Colors.transparent);
          },
        ),
      ),
    );
  }

  Widget _maxStreakWidget() {
    return BlueContainer(
      child: Column(
        children: [
          Text('Max. streak', style: Theme.of(context).textTheme.titleLarge),
          Text('${3} days', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w900)),
          Text('Last done: ${PluginEnum.getUp.name}', style: Theme.of(context).textTheme.labelLarge),
        ],
      ),
    );
  }

  Widget _discoverNewRoutines() {
    return Card(
      color: Theme.of(context).colorScheme.tertiaryContainer,
      child: ListTile(
        title: Text('Discover new Routines here', style: Theme.of(context).textTheme.titleLarge),
        trailing: Icon(Icons.adaptive.arrow_forward_rounded),
        onTap: () => widget.pageController.animateToPage(0, duration: const Duration(milliseconds: 1000), curve: Curves.bounceOut),
      ),
    );
  }
}
