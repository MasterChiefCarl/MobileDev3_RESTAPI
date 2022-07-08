import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:garces_restapi/models/notes_model.dart';
import 'package:garces_restapi/service/notes_service.dart';
import 'package:garces_restapi/views/note_createmodify.dart';
import 'package:garces_restapi/views/note_delete.dart';
import 'package:get_it/get_it.dart';

// ignore: use_key_in_widget_constructors
class NoteList extends StatefulWidget {

  @override
  State<NoteList> createState() => _NoteListState();
}

class _NoteListState extends State<NoteList> {
  NotesService get service => GetIt.I<NotesService>();
  List<NoteForListing> notes =[];

  String formatDateTime(DateTime dateTime) {
    return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
  }
  @override
  void initState(){
    notes = service.getNotesList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('List of Notes')),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (_) => NoteModify()));
        },
        child: const Icon(Icons.add),
      ),
      body: ListView.separated(
        separatorBuilder: (_, __) =>
            const Divider(height: 1, color: Colors.black),
        itemBuilder: (_, index) {
          return Dismissible(
            key: ValueKey(notes[index].noteID),
            direction: DismissDirection.startToEnd,
            onDismissed: (direction) {},
            confirmDismiss: (direction) async {
              final result = await showDialog(
                  context: context, builder: (_) => NoteDelete());
              print(result);
              return result;
            },
            background: Container(
              color: Colors.red,
              padding: const EdgeInsets.only(left: 16),
              child: const Align(
                alignment: Alignment.centerLeft,
                child: Icon(Icons.delete, color: Colors.white),
              ),
            ),
            child: ListTile(
              title: Text(
                notes[index].noteTitle,
                style: TextStyle(color: Theme.of(context).primaryColor),
              ),
              subtitle: Text(
                'Lastest Edit: ${formatDateTime(notes[index].lastEditDateTime)}',
                style: TextStyle(color: Theme.of(context).primaryColor),
              ),
              onLongPress: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => NoteModify(
                          noteID: notes[index].noteID,
                        )));
              },
            ),
          );
        },
        itemCount: notes.length,
      ),
    );
  }
}
