class Todo {
  String id;
  DateTime createdAt;
  DateTime updatedAt;
  String title;
  String description;
  bool isCompleted;

  Todo({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.title,
    required this.description,
    required this.isCompleted,
  });

  factory Todo.fromJson(Map<String, dynamic> json) => Todo(
        id: json["_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        title: json["title"],
        description: json["description"],
        isCompleted: json["is_completed"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "title": title,
        "description": description,
        "is_completed": isCompleted,
      };
}
