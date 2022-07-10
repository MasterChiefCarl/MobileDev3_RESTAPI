// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_key_in_widget_constructors, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';

class NoteModify extends StatelessWidget {
  final String noteID;

  NoteModify({this.noteID = ''});
  bool get isEditing => noteID != '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(isEditing? 'Update Note':'Create Note' )),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: 'Note Title',
              ),
            ),
            SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(
                hintText: 'Note Content',
              ),
            ),
            SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              height: 35,
              child: ElevatedButton(
                onPressed: () {
                  if(isEditing){
                    //update the Note
                  }
                  else{
                    //create a new note
                  }
                  Navigator.of(context).pop();
                },
                child: Text(
                  isEditing ? 'Update Existing Note' : 'Create New Note',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
