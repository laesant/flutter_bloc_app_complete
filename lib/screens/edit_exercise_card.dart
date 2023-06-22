import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_app_complete/blocs/workouts_cubit.dart';
import 'package:flutter_bloc_app_complete/helpers.dart';
import 'package:flutter_bloc_app_complete/models/workout.dart';
import 'package:numberpicker/numberpicker.dart';

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
                child: InkWell(
              onLongPress: () => showDialog(
                  context: context,
                  builder: (_) {
                    final controller = TextEditingController(
                        text: widget
                            .workout!.exercises[widget.exIndex!].prelude!
                            .toString());
                    return AlertDialog(
                      content: TextField(
                          controller: controller,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          decoration: const InputDecoration(
                              labelText: "Prelude (seconds)")),
                      actions: [
                        TextButton(
                            onPressed: () {
                              if (controller.text.isNotEmpty) {
                                Navigator.pop(context);
                                setState(() {
                                  widget.workout!.exercises[widget.exIndex!] =
                                      widget.workout!.exercises[widget.exIndex!]
                                          .copyWith(
                                              prelude:
                                                  int.parse(controller.text));
                                  BlocProvider.of<WorkoutsCubit>(context)
                                      .saveWorkout(
                                          widget.workout!, widget.index);
                                });
                              }
                            },
                            child: const Text("Save"))
                      ],
                    );
                  }),
              child: NumberPicker(
                itemHeight: 30,
                value: widget.workout!.exercises[widget.exIndex!].prelude!,
                maxValue: 3599,
                minValue: 0,
                textMapper: (strVal) => formatTime(int.parse(strVal), false),
                onChanged: (value) => setState(() {
                  widget.workout!.exercises[widget.exIndex!] = widget
                      .workout!.exercises[widget.exIndex!]
                      .copyWith(prelude: value);
                  BlocProvider.of<WorkoutsCubit>(context)
                      .saveWorkout(widget.workout!, widget.index);
                }),
              ),
            )),
            Expanded(
                flex: 3,
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
                )),
            Expanded(
                child: InkWell(
              onLongPress: () => showDialog(
                  context: context,
                  builder: (_) {
                    final controller = TextEditingController(
                        text: widget
                            .workout!.exercises[widget.exIndex!].duration!
                            .toString());
                    return AlertDialog(
                      content: TextField(
                          controller: controller,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          decoration: const InputDecoration(
                              labelText: "Duration (seconds)")),
                      actions: [
                        TextButton(
                            onPressed: () {
                              if (controller.text.isNotEmpty) {
                                Navigator.pop(context);
                                setState(() {
                                  widget.workout!.exercises[widget.exIndex!] =
                                      widget.workout!.exercises[widget.exIndex!]
                                          .copyWith(
                                              duration:
                                                  int.parse(controller.text));
                                  BlocProvider.of<WorkoutsCubit>(context)
                                      .saveWorkout(
                                          widget.workout!, widget.index);
                                });
                              }
                            },
                            child: const Text("Save"))
                      ],
                    );
                  }),
              child: NumberPicker(
                itemHeight: 30,
                value: widget.workout!.exercises[widget.exIndex!].duration!,
                maxValue: 3599,
                minValue: 0,
                textMapper: (strVal) => formatTime(int.parse(strVal), false),
                onChanged: (value) => setState(() {
                  widget.workout!.exercises[widget.exIndex!] = widget
                      .workout!.exercises[widget.exIndex!]
                      .copyWith(duration: value);
                  BlocProvider.of<WorkoutsCubit>(context)
                      .saveWorkout(widget.workout!, widget.index);
                }),
              ),
            )),
          ],
        )
      ],
    );
  }
}
