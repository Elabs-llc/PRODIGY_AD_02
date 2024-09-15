import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo/providers/todo_provider.dart';

class AddTodo extends ConsumerWidget {
  const AddTodo({super.key});

  void _addTodo(WidgetRef ref, TextEditingController titleController,
      TextEditingController contentController, BuildContext context) {
    if (titleController.text.isNotEmpty && contentController.text.isNotEmpty) {
      ref
          .read(todoProvider.notifier)
          .addTodo(titleController.text, contentController.text);
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
      appBar: AppBar(
        title: const Text('Add Todo'),
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
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: titleController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: contentController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            TextButton(
                onPressed: () {
                  _addTodo(ref, titleController, contentController, context);
                },
                child: const Text("Add Todo"))
          ],
        ),
      ),
    );
  }
}
