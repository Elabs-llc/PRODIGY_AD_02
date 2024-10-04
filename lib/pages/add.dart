import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo/data/database_helper.dart';
import 'package:todo/models/todo_model.dart';
import 'package:todo/providers/todo_provider.dart';
import 'package:intl/intl.dart';

class AddTodo extends ConsumerWidget {
  const AddTodo({super.key});

  Future<void> _addTodo(WidgetRef ref, TextEditingController titleController,
      TextEditingController contentController, BuildContext context) async {
    if (titleController.text.isNotEmpty && contentController.text.isNotEmpty) {
      ref
          .read(todoProvider.notifier)
          .addTodo(titleController.text, contentController.text);

      // Initialize the database
      final dbHelper = DatabaseHelper();
      final database = await dbHelper.database;

      // Get the current date and time
      DateTime now = DateTime.now();
      String formattedDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(now);

      // Store records in database
      TodoModel todo = TodoModel(
        todoTitle: titleController.text,
        todoDescription: contentController.text,
        dateAdded: formattedDate,
        isCompleted: false,
      );
      int id = await DatabaseHelper.addTodo(todo);
      if (kDebugMode) {
        print('Todo added with id: $id');
      }

      titleController.clear();
      contentController.clear();
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Please fill in the title and content"),
      ));
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    TextEditingController titleController = TextEditingController();
    TextEditingController contentController = TextEditingController();

    return Scaffold(
      backgroundColor: Colors.yellow[200],
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 243, 220, 12),
        title: const Text('New Todo'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            tooltip: "Save Todo",
            onPressed: () {
              _addTodo(ref, titleController, contentController, context);
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "Todo Title",
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.left,
                ),
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: titleController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                const Text(
                  "Todo Content",
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.left,
                ),
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: contentController,
                      maxLines: 10,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ),
                TextButton(
                    onPressed: () {
                      _addTodo(
                          ref, titleController, contentController, context);
                    },
                    style: const ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(Colors.yellow),
                        padding: WidgetStatePropertyAll(EdgeInsets.all(20)),
                        textStyle: WidgetStatePropertyAll(TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                        ))),
                    child: const Text("Add Todo")),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
