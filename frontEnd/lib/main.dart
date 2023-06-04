import 'package:flutter/material.dart';
import 'package:note_inf272/services/note_services.dart';
import 'package:provider/provider.dart';
import 'package:note_inf272/screens/notes_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => NoteServices()),
        ],
        child: NoteScreen(),
      )
    );
  }
}

