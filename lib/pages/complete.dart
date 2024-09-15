import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo/models/todo_model.dart';
import 'package:todo/providers/todo_provider.dart';

class CompletedTodo extends ConsumerWidget {
  const CompletedTodo({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Get all todos
    List<TodoModel> todos = ref.watch(todoProvider);

    // completed todo list
    List<TodoModel> completedTodo = todos
        .where(
          (todo) => todo.isCompleted == true,
        )
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Completed Todos"),
      ),
      body: ListView.builder(
          itemCount: completedTodo.length,
          itemBuilder: (context, index) {
            if (completedTodo.isEmpty) {
              return const Padding(
                padding: EdgeInsets.only(top: 300.0),
                child: Center(
                  child: Text(
                      "No Completed Todos Available, add new one using the  button below!"),
                ),
              );
            } else {
              return Slidable(
                startActionPane:
                    ActionPane(motion: const ScrollMotion(), children: [
                  SlidableAction(
                    onPressed: (context) => ref
                        .watch(todoProvider.notifier)
                        .deleteTodo(completedTodo[index].todoId),
                    icon: Icons.delete,
                    backgroundColor: Colors.redAccent,
                  ),
                ]),
                child: Container(
                  padding: const EdgeInsets.all(5),
                  margin: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(71, 249, 245, 134),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: ListTile(
                    title: Text(completedTodo[index].todoTitle),
                    subtitle: Text(completedTodo[index].todoDescription),
                    contentPadding: const EdgeInsets.all(5),
                  ),
                ),
              );
            }
          }),
    );
  }
}
