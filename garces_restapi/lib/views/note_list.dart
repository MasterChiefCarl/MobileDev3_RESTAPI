import 'package:flutter/material.dart';
import 'package:garces_restapi/models/notes_model.dart';
import 'package:garces_restapi/views/note_createmodify.dart';
import 'package:garces_restapi/views/note_delete.dart';

// ignore: use_key_in_widget_constructors
class NoteList extends StatelessWidget {
  //hardcoded list of notes

  final notes = [
    NoteForListing(
        noteID: "1",
        createDateTime: DateTime.now(),
        lastEditDateTime: DateTime.now(),
        noteTitle: 'Note 1'),
    NoteForListing(
        noteID: "2",
        createDateTime: DateTime.now(),
        lastEditDateTime: DateTime.now(),
        noteTitle: 'Note 2'),
    NoteForListing(
        noteID: "3",
        createDateTime: DateTime.now(),
        lastEditDateTime: DateTime.now(),
        noteTitle: 'Note 3'),
    NoteForListing(
        noteID: "4",
        createDateTime: DateTime.now(),
        lastEditDateTime: DateTime.now(),
        noteTitle: 'Note 4'),
    NoteForListing(
        noteID: "5",
        createDateTime: DateTime.now(),
        lastEditDateTime: DateTime.now(),
        noteTitle: 'Note 5'),
    NoteForListing(
        noteID: "6",
        createDateTime: DateTime.now(),
        lastEditDateTime: DateTime.now(),
        noteTitle: 'Note 6'),
  ];

  String formatDateTime(DateTime dateTime) {
    return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
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
