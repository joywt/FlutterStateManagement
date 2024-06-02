import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:todo_events/todo_item.dart';
import 'package:todo_events/todo_view_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: ChangeNotifierProvider(
            create: (context) => TodoViewModel(), child: TodoListPage()));
  }
}

class TodoListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    // final todoViewModel = Provider.of<TodoViewModel>(context);
    return Scaffold(
      appBar: AppBar(title: Text("Todo List")),
      body: Consumer<TodoViewModel>(
        builder: (context, todoViewModel, child) {
          return ListView.builder(
            itemCount: todoViewModel.todos.length,
            itemBuilder: (context, index) {
              return TodoItemWidget(
                todo: todoViewModel.todos[index],
                onToggle: () {
                  todoViewModel.toggleTodo(todoViewModel.todos[index]);
                },
                onDelete: () {
                  todoViewModel.removeTodo(todoViewModel.todos[index]);
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          String? newTitle = await showDialog(
              context: context,
              builder: (context) {
                return AddTodoDialog();
              });
          if (newTitle != null) {
            context.read<TodoViewModel>().addTodo(TodoItem(title: newTitle));
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class TodoItemWidget extends StatelessWidget {
  final TodoItem todo;
  final VoidCallback onToggle;
  final VoidCallback onDelete;

  TodoItemWidget(
      {required this.todo, required this.onToggle, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListTile(
      title: Text(todo.title),
      leading: Checkbox(
          value: todo.isDone,
          onChanged: (value) {
            onToggle();
          }),
      trailing: IconButton(
          icon: Icon(Icons.delete),
          onPressed: () {
            onDelete();
          }),
    );
  }
}

class AddTodoDialog extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return AlertDialog(
        title: Text("Add Todo"),
        content: TextField(
          controller: _controller,
          decoration: InputDecoration(hintText: 'Todo title'),
        ),
        actions: [
          TextButton(
            child: Text("Cancel"),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          TextButton(
              child: Text("Add"),
              onPressed: () {
                Navigator.of(context).pop(_controller.text);
              })
        ]);
  }
}
