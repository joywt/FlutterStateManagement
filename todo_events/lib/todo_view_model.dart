import 'package:flutter/foundation.dart';
import 'package:todo_events/todo_item.dart';
import 'package:todo_events/todo_service.dart';

class TodoViewModel extends ChangeNotifier {
  final TodoService _todoService = TodoService();
  List<TodoItem> get todos => _todoService.todos;

  void addTodo(TodoItem todo) {
    _todoService.addTodo(todo);
    notifyListeners();
  }

  void removeTodo(TodoItem todo) {
    _todoService.removeTodo(todo);
    notifyListeners();
  }

  void toggleTodo(TodoItem todo) {
    _todoService.toggleTodoStatus(todo);
    notifyListeners();
  }
}
