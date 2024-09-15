import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo/models/todo_model.dart';
import 'package:todo/pages/add.dart';
import 'package:todo/pages/complete.dart';
import 'package:todo/providers/todo_provider.dart';

class MyHomePage extends ConsumerWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Get all todos
    List<TodoModel> todos = ref.watch(todoProvider);
    // active todo list
    List<TodoModel> activeTodos = todos
        .where(
          (todo) => todo.isCompleted == false,
        )
        .toList();
    // completed todo list
    List<TodoModel> completedTodo = todos
        .where(
          (todo) => todo.isCompleted == true,
        )
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Todo"),
      ),
      body: ListView.builder(
          itemCount: activeTodos.length + 1,
          itemBuilder: (context, index) {
            if (index == activeTodos.length) {
              if (completedTodo.isEmpty) {
                return Container();
              } else {
                return Center(
                  child: TextButton(
                      onPressed: () => Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => const CompletedTodo())),
                      child: Text("Completed Todos")),
                );
              }
            } else {
              return Slidable(
                startActionPane: ActionPane(motion: ScrollMotion(), children: [
                  SlidableAction(
                    onPressed: (context) =>
                        ref.watch(todoProvider.notifier).deleteTodo(index),
                    icon: Icons.delete,
                    backgroundColor: Colors.redAccent,
                  ),
                ]),
                endActionPane: ActionPane(motion: ScrollMotion(), children: [
                  SlidableAction(
                    onPressed: (context) =>
                        ref.watch(todoProvider.notifier).completeTodo(index),
                    icon: Icons.check_circle_outline,
                    backgroundColor: Colors.lightGreen,
                  ),
                ]),
                child: ListTile(
                  title: Text(activeTodos[index].todoTitle),
                  subtitle: Text(activeTodos[index].todoDescription),
                  contentPadding: EdgeInsets.all(5),
                ),
              );
            }
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => const AddTodo()));
        },
        tooltip: 'New Todo',
        child: const Icon(Icons.add),
      ),
    );
  }
}
