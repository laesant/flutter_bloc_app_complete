import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_app_complete/blocs/workout_cubit.dart';
import 'package:flutter_bloc_app_complete/helpers.dart';
import 'package:flutter_bloc_app_complete/models/exercise.dart';
import 'package:flutter_bloc_app_complete/states/workout_state.dart';

import 'edit_exercise_card.dart';

class EditWorkoutPage extends StatelessWidget {
  const EditWorkoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child:
            BlocBuilder<WorkoutCubit, WorkoutState>(builder: (context, state) {
          WorkoutEditing we = state as WorkoutEditing;
          return Scaffold(
              appBar: AppBar(
                  leading: BackButton(
                      onPressed: () =>
                          BlocProvider.of<WorkoutCubit>(context).goHome())),
              body: ListView.builder(
                  itemCount: we.workout!.exercises.length,
                  itemBuilder: (context, index) {
                    Exercise exercise = we.workout!.exercises[index];
                    if (we.exIndex == index) {
                      return EditExerciseCard(
                          workout: we.workout,
                          index: we.index,
                          exIndex: we.exIndex);
                    } else {
                      return ListTile(
                          onTap: () => BlocProvider.of<WorkoutCubit>(context)
                              .editExercise(index),
                          leading: Text(formatTime(exercise.prelude!, true)),
                          title: Text(exercise.title!,
                              textAlign: TextAlign.center),
                          trailing: Text(formatTime(exercise.duration!, true)));
                    }
                  }));
        }),
        onWillPop: () => BlocProvider.of<WorkoutCubit>(context).goHome());
  }
}
