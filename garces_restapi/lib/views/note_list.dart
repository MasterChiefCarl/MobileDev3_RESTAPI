// ignore_for_file: unused_import, avoid_print

import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:garces_restapi/models/api_response_model.dart';
import 'package:garces_restapi/service/notes_service.dart';
import 'package:garces_restapi/views/note_createmodify.dart';
import 'package:garces_restapi/views/note_delete.dart';
import 'package:get_it/get_it.dart';

import '../models/notes_model.dart';

// ignore: use_key_in_widget_constructors
class NoteList extends StatefulWidget {
  @override
  State<NoteList> createState() => _NoteListState();
}

class _NoteListState extends State<NoteList> {
  //tells the widget / view to get the data from a service.
  NotesService get service => GetIt.I<NotesService>();
  
  late APIResponse<List<NoteForListing>> _apiResponse;
  
  bool _isLoading = false;
  String formatDateTime(DateTime dateTime) {
    return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
  }

  @override
  void initState() {
    //they dont see if the code is hard coded or called from an API.
    //_apiResponse.data collect the _apiResponse.data data from a services that holds all the _apiResponse.data data.
    _fetchNotes();
    super.initState();
  }

  _fetchNotes() async {
    setState(() {
      _isLoading = true;
    });

    _apiResponse = await service.getNotesList();

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('List of _apiResponse.data')),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => NoteModify()));
          },
          child: const Icon(Icons.add),
        ),
        body: Builder(builder: (_) {
          if (_isLoading) {
            return CircularProgressIndicator(
              color: Theme.of(context).primaryColor,
            );
          }

          if (_apiResponse.error) {
            return Center(
              child: Text(_apiResponse.errorMessage),
            );
          }
          return ListView.separated(
            separatorBuilder: (_, __) =>
                const Divider(height: 1, color: Colors.black),
            itemBuilder: (_, index) {
              return Dismissible(
                key: ValueKey(_apiResponse.data[index].noteID),
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
                    _apiResponse.data[index].noteTitle,
                    style: TextStyle(color: Theme.of(context).primaryColor),
                  ),
                  subtitle: Text(
                    'Lastest Edit: ${formatDateTime(_apiResponse.data[index].latestEditDateTime)}',
                    style: TextStyle(color: Theme.of(context).primaryColor),
                  ),
                  onLongPress: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) => NoteModify(
                              noteID: _apiResponse.data[index].noteID,
                            )));
                  },
                ),
              );
            },
            itemCount: _apiResponse.data.length,
          );
        }));
  }
}
