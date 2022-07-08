import 'package:flutter/material.dart';
import 'package:garces_restapi/service/notes_service.dart';
import 'package:garces_restapi/views/note_list.dart';
import 'package:get_it/get_it.dart';

void setupLocator() {
  GetIt.I.registerLazySingleton(() => NotesService()); 
  // to be only called one time becausewe dont need multiple instances of the service...
}

void main() {
  setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      debugShowCheckedModeBanner: false,
      home: NoteList(),
    );
  }
}

