import 'package:todo_events/todo_item.dart';

class TodoService {
  List<TodoItem> _todos = [];
  List<TodoItem> get todos => _todos;

  void addTodo(TodoItem todo) {
    _todos.add(todo);
  }

  void removeTodo(TodoItem todo) {
    _todos.remove(todo);
  }

  void toggleTodoStatus(TodoItem todo) {
    todo.isDone = !todo.isDone;
  }
}
