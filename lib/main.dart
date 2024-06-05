import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_do_app/app/app.dart';

// void main() {
//   runApp(
//     const App(),
//   );
// }
void main() {
  runApp(const ProviderScope(
    child: App()
    ));
}
