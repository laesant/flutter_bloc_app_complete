import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_app_complete/blocs/workout_cubit.dart';
import 'package:flutter_bloc_app_complete/states/workout_state.dart';

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
                  itemBuilder: (context, index) {}));
        }),
        onWillPop: () => BlocProvider.of<WorkoutCubit>(context).goHome());
  }
}
