import 'package:flutter/material.dart';
import 'package:to_do_app/screen/todo_list_screen.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: TodoListScreen(),
    );
  }
}
