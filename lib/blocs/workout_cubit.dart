import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_app_complete/models/workout.dart';

import '../states/workout_state.dart';

class WorkoutCubit extends Cubit<WorkoutState> {
  WorkoutCubit() : super(const WorkoutInitial());

  void editWorkout(Workout workout, int index) =>
      emit(WorkoutEditing(workout, index, null));

  void editExercise(int? exIndex) => emit(
      WorkoutEditing(state.workout, (state as WorkoutEditing).index, exIndex));

  dynamic goHome() => emit(const WorkoutInitial());
}
