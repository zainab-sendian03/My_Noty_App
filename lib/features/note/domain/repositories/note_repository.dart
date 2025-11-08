import 'package:firebase_test/features/note/domain/entities/note_entity.dart';

abstract class NoteRepository {
  Future<NoteEntity> addNote(String title, String content, String imageUrl);
  Future<List<NoteEntity>> getNotes();
  Future<NoteEntity> getNoteById(String noteId);
  Future<void> updateNote(
      String noteId, String title, String content, String imageUrl);
  Future<void> deleteNote(String noteId);
}
