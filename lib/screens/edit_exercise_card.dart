import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_app_complete/blocs/workouts_cubit.dart';
import 'package:flutter_bloc_app_complete/models/workout.dart';

class EditExerciseCard extends StatefulWidget {
  final Workout? workout;
  final int index;
  final int? exIndex;
  const EditExerciseCard(
      {super.key, this.workout, required this.index, this.exIndex});

  @override
  State<EditExerciseCard> createState() => _EditExerciseCardState();
}

class _EditExerciseCardState extends State<EditExerciseCard> {
  TextEditingController? _title;

  @override
  void initState() {
    _title = TextEditingController(
        text: widget.workout!.exercises[widget.exIndex!].title);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
                child: TextField(
              controller: _title,
              textAlign: TextAlign.center,
              onChanged: (value) => setState(() {
                widget.workout!.exercises[widget.exIndex!] = widget
                    .workout!.exercises[widget.exIndex!]
                    .copyWith(title: value);
                BlocProvider.of<WorkoutsCubit>(context)
                    .saveWorkout(widget.workout!, widget.index);
              }),
            ))
          ],
        )
      ],
    );
  }
}
