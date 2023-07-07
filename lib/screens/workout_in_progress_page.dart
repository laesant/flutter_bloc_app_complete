import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_app_complete/blocs/workout_cubit.dart';
import 'package:flutter_bloc_app_complete/models/workout.dart';
import 'package:flutter_bloc_app_complete/states/workout_state.dart';

class WorkoutInProgressPage extends StatelessWidget {
  const WorkoutInProgressPage({super.key});

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> _getStats(Workout workout, int workoutElapsed) {
      return {"workoutTitle": workout.title};
    }

    return BlocConsumer<WorkoutCubit, WorkoutState>(
        builder: (context, state) {
          return Center(child: Text("${state.elapsed}"));
        },
        listener: (context, state) {});
  }
}
