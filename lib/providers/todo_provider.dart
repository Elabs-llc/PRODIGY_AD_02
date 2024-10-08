import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo/data/helper.dart';
import 'package:todo/models/todo_model.dart';

final todoProvider =
    StateNotifierProvider<TodoListNotifier, List<TodoModel>>((ref) {
  return TodoListNotifier();
});

class TodoListNotifier extends StateNotifier<List<TodoModel>> {
  TodoListNotifier() : super([]);
  // Add Todo
  void addTodo(String title, String content) {
    state = [
      ...state,
      TodoModel(
        todoId: state.isEmpty ? 0 : state[state.length - 1].todoId! + 1,
        todoTitle: title,
        todoDescription: content,
        isCompleted: false,
        dateAdded: Helper.getDate(),
      )
    ];
  }

  // complete todo
  void completeTodo(int id) {
    state = [
      for (final todo in state)
        if (todo.todoId == id)
          TodoModel(
              todoId: todo.todoId,
              todoTitle: todo.todoTitle,
              todoDescription: todo.todoDescription,
              isCompleted: true,
              dateAdded: Helper.getDate())
        else
          todo
    ];
  }

  // delet todo
  void deleteTodo(int id) {
    state = state.where((todo) => todo.todoId != id).toList();
  }
}
