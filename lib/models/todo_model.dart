class TodoModel {
  int todoId;
  String todoTitle;
  String todoDescription;
  bool isCompleted;

  TodoModel(
      {required this.todoId,
      required this.todoTitle,
      required this.todoDescription,
      required this.isCompleted});
}
