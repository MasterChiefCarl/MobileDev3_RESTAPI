import 'package:garces_restapi/models/notes_model.dart';

class NotesService {
  List<NoteForListing> getNotesList() {
    
    return [
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
  }
}
