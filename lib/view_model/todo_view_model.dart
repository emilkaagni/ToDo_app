import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/todo_model.dart';

// StateNotifier to manage the list of Todos
class TodoListNotifier extends StateNotifier<List<Todo>> {
  TodoListNotifier()
      : super([
          Todo(title: 'electricity'),
          Todo(title: 'Call'),
          Todo(title: 'Visit'),
          Todo(title: 'Buy sweets'),
          Todo(title: 'Cook'),
        ]);

  void addTodo(Todo todo) {
    state = [...state, todo];
  }

  void toggleDone(Todo todo) {
    state = [
      for (final item in state)
        if (item == todo)
          Todo(
            title: item.title,
            isDone: !item.isDone,
            isFavorite: item.isFavorite,
          )
        else
          item
    ];
  }

  void toggleFavorite(Todo todo) {
    state = [
      for (final item in state)
        if (item == todo)
          Todo(
            title: item.title,
            isDone: item.isDone,
            isFavorite: !item.isFavorite,
          )
        else
          item
    ];
  }
}

// Provider to access TodoListNotifier
final todoListProvider =
    StateNotifierProvider<TodoListNotifier, List<Todo>>((ref) {
  return TodoListNotifier();
});
