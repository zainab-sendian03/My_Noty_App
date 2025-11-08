import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_test/features/note/domain/entities/note_entity.dart';
import 'package:firebase_test/features/note/domain/repositories/note_repository.dart';

class NoteRepositoryImpl implements NoteRepository {
  final FirebaseFirestore _firestore;

  NoteRepositoryImpl() : _firestore = FirebaseFirestore.instance;

  @override
  Future<NoteEntity> addNote(
      String title, String content, String imageUrl) async {
    try {
      final docRef = await _firestore.collection('notes').add({
        'title': title,
        'content': content,
        'imageUrl': imageUrl,
        'createdAt': FieldValue.serverTimestamp(),
      });

      return NoteEntity(
        docRef.id,
        title,
        content,
        imageUrl,
      );
    } catch (e) {
      throw Exception('Failed to add note: $e');
    }
  }

  @override
  Future<void> deleteNote(String noteId) {
    // TODO: implement deleteNote
    throw UnimplementedError();
  }

  @override
  Future<NoteEntity> getNoteById(String noteId) {
    // TODO: implement getNoteById
    throw UnimplementedError();
  }

  @override
  Future<List<NoteEntity>> getNotes() {
    // TODO: implement getNotes
    throw UnimplementedError();
  }

  @override
  Future<void> updateNote(
      String noteId, String title, String content, String imageUrl) {
    // TODO: implement updateNote
    throw UnimplementedError();
  }
}
