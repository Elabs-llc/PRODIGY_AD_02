class TodoModel {
  int? todoId;
  String todoTitle;
  String todoDescription;
  String dateAdded;
  bool isCompleted = false;

  TodoModel({
    this.todoId,
    required this.todoTitle,
    required this.todoDescription,
    required this.dateAdded,
    this.isCompleted = false,
  });

  factory TodoModel.fromMap(Map<String, dynamic> map) {
    return TodoModel(
      todoId: map['id'],
      todoTitle: map['title'],
      todoDescription: map['description'],
      dateAdded: map['date_added'],
      isCompleted: map['completed'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': todoId,
      'title': todoTitle,
      'description': todoDescription,
      'date_added': dateAdded,
      'completed': isCompleted ? 1 : 0,
    };
  }
}
