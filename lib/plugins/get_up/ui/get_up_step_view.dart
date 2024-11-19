import 'package:blue_tine_deferred_components/plugins/get_up/data/get_up_routine_step.dart';
import 'package:blue_tine_deferred_components/utils/format_util.dart';
import 'package:flutter/material.dart';

class GetUpStepView extends StatelessWidget {
  final GetUpRoutineStep data;

  const GetUpStepView(this.data, {super.key, required});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(40.0),
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(parent: BouncingScrollPhysics()),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Expanded(flex: 1, child: Text('Name: ', style: TextStyle(fontWeight: FontWeight.bold))),
                  Expanded(flex: 1, child: Text(data.name)),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Expanded(child: Text('Description: ', style: TextStyle(fontWeight: FontWeight.bold))),
                  Expanded(child: Text(data.description ?? '')),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Expanded(flex: 1, child: Text('Duration: ', style: TextStyle(fontWeight: FontWeight.bold))),
                  Expanded(flex: 1, child: Text(data.duration.formatDuration())),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Expanded(flex: 1, child: Text('Is active? ', style: TextStyle(fontWeight: FontWeight.bold))),
                  Expanded(
                      flex: 1,
                      child: Text(
                        data.isActive ? ' Yes' : 'No',
                        style: TextStyle(color: data.isActive ? Colors.green : Colors.red),
                      )),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
