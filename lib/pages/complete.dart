import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo/models/todo_model.dart';
import 'package:todo/pages/add.dart';
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
        title: const Text("Todo"),
      ),
      body: ListView.builder(
          itemCount: completedTodo.length,
          itemBuilder: (context, index) {
            return Slidable(
              startActionPane: ActionPane(motion: ScrollMotion(), children: [
                SlidableAction(
                  onPressed: (context) =>
                      ref.watch(todoProvider.notifier).deleteTodo(index),
                  icon: Icons.delete,
                  backgroundColor: Colors.redAccent,
                ),
              ]),
              child: ListTile(
                title: Text(completedTodo[index].todoTitle),
                subtitle: Text(completedTodo[index].todoDescription),
                contentPadding: EdgeInsets.all(5),
              ),
            );
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
