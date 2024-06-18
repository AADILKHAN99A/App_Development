class Task {
  String? id;
  String title;
  String note;
  int isCompleted;
  String date;
  String startTime;
  String endTime;
  int color;
  int remind;
  String repeat;

  Task(
      {this.id,
      required this.title,
      required this.note,
      required this.isCompleted,
      required this.date,
      required this.startTime,
      required this.endTime,
      required this.color,
      required this.remind,
      required this.repeat});

  factory Task.fromJson(Map<String, dynamic> data) => Task(
      id: data['id'],
      title: data['title'],
      note: data['note'],
      isCompleted: data['isCompleted'],
      date: data['date'],
      startTime: data['startTime'],
      endTime: data['endTime'],
      color: data['color'],
      remind: data['remind'],
      repeat: data['repeat']);

  copy({required String id, required Task task}) => Task(
      title: task.title,
      note: task.note,
      isCompleted: task.isCompleted,
      date: task.date,
      startTime: task.startTime,
      endTime: task.endTime,
      color: task.color,
      remind: task.remind,
      repeat: task.repeat,
      id: id);

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'note': note,
      'isCompleted': isCompleted,
      'date': date,
      'startTime': startTime,
      'endTime': endTime,
      'color': color,
      'remind': remind,
      'repeat': repeat
    };
  }
}
