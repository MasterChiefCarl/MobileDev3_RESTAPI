// ignore_for_file: import_of_legacy_library_into_null_safe, constant_identifier_names

import 'dart:convert';

import 'package:garces_restapi/models/api_response_model.dart';
import 'package:garces_restapi/models/notes_model.dart';
import 'package:http/http.dart' as http;

//services hold the data making the views not see what's going on
//services calls methods that send the data to the views

// we use the service locator (located in the main.dart file) to find the services.

class NotesService {
  static const API = 'https://tq-notes-api-jkrgrdggbq-el.a.run.app';
  static const headers = {
    'apiKey': 'd931e8f7-1d97-4f92-ab38-a6f2e36c10e2',
  };

  Future<APIResponse<List<NoteForListing>>> getNotesList() async {
    
    return await http.get(Uri.parse('$API/notes'), headers: headers).then((data) {
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
        final notes = <NoteForListing>[];
        for (var item in jsonData) {
          final note = NoteForListing(
            noteID: item['noteID'],
            noteTitle: item['noteTitle'],
            createDateTime: DateTime.parse(item['createDateTime']),
            latestEditDateTime: item['latestEditDateTime'] != null
                ? DateTime.parse(item['latestEditDateTime'])
                : DateTime.parse(item['createDateTime']),
          );
          notes.add(note);
        }
        return APIResponse<List<NoteForListing>>(data: notes);
      }
      return APIResponse<List<NoteForListing>>(
          data: [], error: true, errorMessage: 'An Error occurred');
    }).catchError((_) => APIResponse<List<NoteForListing>>(
        data: [], error: true, errorMessage: 'An Error occurred'));
  }
}
