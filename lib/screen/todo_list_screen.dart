import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/todo_model.dart';
import '../view_model/todo_view_model.dart';

class TodoListScreen extends ConsumerStatefulWidget {
  const TodoListScreen({super.key});

  @override
  TodoListScreenState createState() => TodoListScreenState();
}

class TodoListScreenState extends ConsumerState<TodoListScreen> {
  String filter = 'All';

  @override
  Widget build(BuildContext context) {
    final todos = ref.watch(todoListProvider);

    final filteredTodos = todos.where((todo) {
      if (filter == 'All') return true;
      if (filter == 'Active') return !todo.isDone;
      if (filter == 'Favourite') return todo.isFavorite;
      if (filter == 'Done') return todo.isDone;
      return false;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Todopad'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: const InputDecoration(
                labelText: 'What do you want to do?',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  filter = value;
                });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FilterButton(
                  label: 'All',
                  isSelected: filter == 'All',
                  onPressed: () {
                    setState(() {
                      filter = 'All';
                    });
                  },
                ),
                FilterButton(
                  label: 'Active',
                  isSelected: filter == 'Active',
                  onPressed: () {
                    setState(() {
                      filter = 'Active';
                    });
                  },
                ),
                FilterButton(
                  label: 'Favourite',
                  isSelected: filter == 'Favourite',
                  onPressed: () {
                    setState(() {
                      filter = 'Favourite';
                    });
                  },
                ),
                FilterButton(
                  label: 'Done',
                  isSelected: filter == 'Done',
                  onPressed: () {
                    setState(() {
                      filter = 'Done';
                    });
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredTodos.length,
              itemBuilder: (context, index) {
                final todo = filteredTodos[index];
                return TodoItem(
                  todo: todo,
                  onToggleDone: () {
                    ref.read(todoListProvider.notifier).toggleDone(todo);
                  },
                  onToggleFavorite: () {
                    ref.read(todoListProvider.notifier).toggleFavorite(todo);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class FilterButton extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onPressed;

  const FilterButton({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected ? Colors.green : Colors.grey,
      ),
      onPressed: onPressed,
      child: Text(label),
    );
  }
}

class TodoItem extends StatelessWidget {
  final Todo todo;
  final VoidCallback onToggleDone;
  final VoidCallback onToggleFavorite;

  const TodoItem({
    super.key,
    required this.todo,
    required this.onToggleDone,
    required this.onToggleFavorite,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(todo.title),
      leading: Checkbox(
        value: todo.isDone,
        onChanged: (value) => onToggleDone(),
      ),
      trailing: IconButton(
        icon: Icon(
          todo.isFavorite ? Icons.star : Icons.star_border,
          color: todo.isFavorite ? Colors.yellow : null,
        ),
        onPressed: onToggleFavorite,
      ),
    );
  }
}
