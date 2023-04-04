import 'package:appwrite/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';
import 'package:todo_app_appwrite/controllers/todo_provider.dart';

class EditTodo extends StatefulWidget {
  const EditTodo({super.key});

  @override
  State<EditTodo> createState() => _EditTodoState();
}

class _EditTodoState extends State<EditTodo> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();

  // call the provider
  @override
  Widget build(BuildContext context) {
    TodoProvider provider = Provider.of<TodoProvider>(context);

    // catch the aguments

    final Document arguments =
        ModalRoute.of(context)?.settings.arguments as Document;
    titleController.text = arguments.data['title'];
    descController.text = arguments.data['description'];

    return Scaffold(
      appBar: AppBar(title: Text("Edit Todo")),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(children: [
            TextFormField(
              controller: titleController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), label: Text("Title")),
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              maxLines: 8,
              controller: descController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), label: Text("Descriprion")),
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
                onPressed: () {
                  provider.updateTodo(
                      titleController.text, descController.text, arguments.$id);
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text("Todo Updated")));
                  Navigator.pop(context);
                },
                child: Text("Update Todo"))
          ]),
        ),
      ),
    );
  }
}
