import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_bloc_app_complete/models/exercise.dart';
import 'package:flutter_bloc_app_complete/models/workout.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class WorkoutsCubit extends HydratedCubit<List<Workout>> {
  WorkoutsCubit() : super([]);

  getWorkouts() async {
    final List<Workout> workouts = [];
    final workoutsJson =
        jsonDecode(await rootBundle.loadString("assets/workouts.json"));
    for (var element in (workoutsJson as Iterable)) {
      workouts.add(Workout.fromJson(element));
    }
    emit(workouts);
  }

  void saveWorkout(Workout workout, int index) {
    Workout newWorkout = Workout(title: workout.title, exercises: []);
    int exIndex = 0;
    int startTime = 0;
    for (var ex in workout.exercises) {
      newWorkout.exercises.add(Exercise(
          title: ex.title,
          prelude: ex.prelude,
          duration: ex.duration,
          index: ex.index,
          startTime: ex.startTime));
      exIndex++;
      startTime += ex.prelude! + ex.duration!;
    }
    state[index] = newWorkout;
    emit([...state]);
  }

  @override
  List<Workout>? fromJson(Map<String, dynamic> json) {
    List<Workout> workouts = [];
    json['workouts']
        .forEach((element) => workouts.add(Workout.fromJson(element)));
    return workouts;
  }

  @override
  Map<String, dynamic>? toJson(List<Workout> state) {
    var json = {'workouts': []};
    for (Workout workout in state) {
      json['workouts']!.add(workout.toJson());
    }
    return json;
  }
}
