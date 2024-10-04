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
      backgroundColor: Colors.yellow[200],
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 243, 220, 12),
        title: const Text("Todo"),
        actions: [
          completedTodo.isEmpty
              ? const Text("")
              : IconButton(
                  onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const CompletedTodo())),
                  icon: const Icon(Icons.note_rounded),
                  color: Colors.green,
                  tooltip: "Completed Todo",
                ),
        ],
      ),
      body: SafeArea(
        child: ListView.builder(
            itemCount: activeTodos.length + 1,
            itemBuilder: (context, index) {
              if (activeTodos.isEmpty) {
                return const Padding(
                  padding: EdgeInsets.only(top: 200.0, left: 20.0, right: 20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image(
                        image: AssetImage('assets/images/box.png'),
                        width: 150.0,
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Center(
                        child: Text(
                          "No Todos Available, add new one using the  button below!",
                          style: TextStyle(
                            fontSize: 20.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              } else if (index == activeTodos.length) {
                if (completedTodo.isEmpty) {
                  return Container();
                } else {
                  return Center(
                    child: TextButton(
                        onPressed: () => Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => const CompletedTodo())),
                        child: const Text("Completed Todos")),
                  );
                }
              } else {
                return Slidable(
                  startActionPane:
                      ActionPane(motion: const ScrollMotion(), children: [
                    SlidableAction(
                      onPressed: (context) => ref
                          .watch(todoProvider.notifier)
                          .deleteTodo(activeTodos[index].todoId!),
                      icon: Icons.delete,
                      backgroundColor: Colors.redAccent,
                    ),
                  ]),
                  endActionPane:
                      ActionPane(motion: const ScrollMotion(), children: [
                    SlidableAction(
                      onPressed: (context) => ref
                          .watch(todoProvider.notifier)
                          .completeTodo(activeTodos[index].todoId!),
                      icon: Icons.check_circle_outline,
                      backgroundColor: Colors.lightGreen,
                    ),
                  ]),
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    margin: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.yellow[400],
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: ListTile(
                      title: Text(activeTodos[index].todoTitle),
                      subtitle: Text(activeTodos[index].todoDescription),
                      contentPadding: const EdgeInsets.all(5),
                    ),
                  ),
                );
              }
            }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => const AddTodo()));
        },
        backgroundColor: Colors.yellow,
        foregroundColor: Colors.black,
        tooltip: 'New Todo',
        elevation: 2.0,
        child: const Icon(Icons.add),
      ),
    );
  }
}
