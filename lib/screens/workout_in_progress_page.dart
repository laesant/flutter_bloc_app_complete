import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_app_complete/blocs/workout_cubit.dart';
import 'package:flutter_bloc_app_complete/helpers.dart';
import 'package:flutter_bloc_app_complete/models/exercise.dart';
import 'package:flutter_bloc_app_complete/models/workout.dart';
import 'package:flutter_bloc_app_complete/states/workout_state.dart';

class WorkoutInProgressPage extends StatelessWidget {
  const WorkoutInProgressPage({super.key});

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> _getStats(Workout workout, int workoutElapsed) {
      int workoutTotal = workout.getTotal();
      Exercise exercise = workout.getCurrentExercise(workoutElapsed);
      int exerciseElapsed = workoutElapsed - exercise.startTime!;
      int exerciseRemaining = exercise.prelude! - exerciseElapsed;
      bool isPrelude = exerciseElapsed < exercise.prelude!;
      int exerciseTotal = isPrelude ? exercise.prelude! : exercise.duration!;
      if (!isPrelude) {
        exerciseElapsed -= exercise.prelude!;
        exerciseRemaining += exercise.duration!;
      }
      return {
        "workoutTitle": workout.title,
        "workoutProgress": workoutElapsed / workoutTotal,
        "workoutElapsed": workoutElapsed,
        "totalExercise": workout.exercises.length,
        "currentExerciseIndex": exercise.index!,
        "workoutRemaining": workoutTotal - workoutElapsed,
        "exerciseRemaining": exerciseRemaining,
        "exerciseProgress": exerciseElapsed / exerciseTotal,
        "isPrelude": isPrelude
      };
    }

    return BlocConsumer<WorkoutCubit, WorkoutState>(
        builder: (ctx, state) {
          final stats = _getStats(state.workout!, state.elapsed!);
          return Scaffold(
            appBar: AppBar(
                leading:
                    BackButton(onPressed: context.read<WorkoutCubit>().goHome),
                title: Text(state.workout!.title!),
                centerTitle: true),
            body: Padding(
              padding: const EdgeInsets.all(32),
              child: Column(
                children: [
                  LinearProgressIndicator(
                      backgroundColor: Colors.blue[100],
                      minHeight: 10,
                      value: stats['workoutProgress']),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(formatTime(stats['workoutElapsed'], true)),
                      DotsIndicator(
                        dotsCount: stats['totalExercise'],
                        position: stats['currentExerciseIndex'],
                      ),
                      Text('-${formatTime(stats['workoutRemaining'], true)}')
                    ],
                  ),
                  const Spacer(),
                  InkWell(
                      child: Stack(alignment: const Alignment(0, 0), children: [
                    Center(
                        child: SizedBox(
                            height: 220,
                            width: 220,
                            child: CircularProgressIndicator(
                                strokeWidth: 25,
                                value: stats['exerciseProgress'],
                                valueColor: AlwaysStoppedAnimation<Color>(
                                    stats['isPrelude']
                                        ? Colors.red
                                        : Theme.of(context).primaryColor)))),
                    Center(
                        child: SizedBox(
                            height: 300,
                            width: 300,
                            child: Padding(
                                padding: const EdgeInsets.only(bottom: 20),
                                child: Image.asset('assets/stopwatch.png'))))
                  ]))
                ],
              ),
            ),
          );
        },
        listener: (context, state) {});
  }
}
