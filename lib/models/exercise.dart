class Exercise {
  final String? title;
  final int? prelude;
  final int? duration;
  final int? index;
  final int? startTime;

  Exercise(
      {required this.title,
      required this.prelude,
      required this.duration,
      this.index,
      this.startTime});

  factory Exercise.fromJson(Map<String, dynamic> json) => Exercise(
        title: json["title"],
        prelude: json["prelude"],
        duration: json["duration"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "prelude": prelude,
        "duration": duration,
      };
}
