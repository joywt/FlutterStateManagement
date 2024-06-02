# Provider

provider 是一个非常流行的 Flutter 状态管理库，它的设计目的是使状态管理变得简单而高效。

### 核心概念

**Provider**：基本的提供者，它将一个值（状态）注入到多个 Widget 中。任何使用这个值的 Widget 都可以通过 **`Provider.of`** 或 **`Consumer`** Widget 访问它。

**ChangeNotifierProvider**：它用于提供一个 **`ChangeNotifier`** 模型的实例。当模型调用 **`notifyListeners()`** 时，所有使用该模型的 Widget 将自动重建。

**Consumer**：一个 Widget，它依赖于 **`Provider`** 提供的值。当提供的值更新时，**`Consumer`** 将重建其子 Widget。

**Selector**：类似于 **`Consumer`**，但允许你仅在特定的值更改时重建 Widget。

### 如何使用

1. 创建模型

   ```dart
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
   ```

   

2. 使用 ChangeNotifierProvider

   ```dart
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
   ```

   

3. 访问和使用状态。在 Widget 树中的任何位置，你都可以通过 Provider.of 或 Consumer Widget 访问到状态模型 

```dart
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
```

