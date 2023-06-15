import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_app_complete/blocs/workouts_cubit.dart';
import 'package:flutter_bloc_app_complete/models/workout.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Workout Time!"),
          actions: [
            IconButton(
                onPressed: () {}, icon: const Icon(Icons.event_available)),
            IconButton(onPressed: () {}, icon: const Icon(Icons.settings))
          ],
        ),
        body: SingleChildScrollView(
          child: BlocBuilder<WorkoutsCubit, List<Workout>>(
            builder: (context, workouts) => ExpansionPanelList.radio(
              children: workouts
                  .map((workout) => ExpansionPanelRadio(
                      value: workout,
                      headerBuilder: (context, isExpanded) => ListTile(
                            visualDensity: const VisualDensity(
                                horizontal: 0,
                                vertical: VisualDensity.maximumDensity),
                            leading: IconButton(
                                onPressed: () {}, icon: const Icon(Icons.edit)),
                            title: Text(workout.title!),
                          ),
                      body: ListView.builder(
                        itemCount: workout.exercises.length,
                        itemBuilder: (context, index) => ListTile(
                          onTap: () {},
                          visualDensity: const VisualDensity(
                              horizontal: 0,
                              vertical: VisualDensity.maximumDensity),
                          leading: IconButton(
                              onPressed: () {}, icon: const Icon(Icons.edit)),
                          title: Text(workout.exercises[index].title!),
                        ),
                      )))
                  .toList(),
            ),
          ),
        ));
  }
}
